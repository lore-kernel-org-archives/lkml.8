Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A921C22CB3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259773;
	bh=Zr7p3Ul/aFedOfHDFZhKZYtxges4GwoHHWtfyuMiZkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g/Q5MTN9+q+EPlhS8FzniTwoofQ4MAOJ2Aag0uOm3ME4NDlxOwjOJOjl1EB0lTCmQ
	 oL+vslxQ4CrwClPvQpzZA9Y7tC5XzdniTwnAZniP9Jwdu3/fxQQ0AS1PiBRnkl+4Yn
	 /hp/ICp2W+kPLXsh0U6yNYLLISDr6t6X960S//kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgGTPmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgGTPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:42:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7992064B;
        Mon, 20 Jul 2020 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259764;
        bh=Zr7p3Ul/aFedOfHDFZhKZYtxges4GwoHHWtfyuMiZkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsdUqz8MBiGMceY3uxbOTMKCC+PXFwjbqOoSfOIkJcXBU9lZnTlh1+BOvJ1CgtUFz
         E1dpY5L8vLYlyQw7DmBR32yCDf4wxZsMwGlHMEUY9mMmM47sGQIdLJQQEiMPPh4wPE
         BgLg7SnMfkTWzp+Fauq+ZLgR5wyjPWVyrHKUU0pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 4.9 64/86] USB: c67x00: fix use after free in c67x00_giveback_urb
Date:   Mon, 20 Jul 2020 17:37:00 +0200
Message-Id: <20200720152756.388997147@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit 211f08347355cba1f769bbf3355816a12b3ddd55 upstream.

clang static analysis flags this error

c67x00-sched.c:489:55: warning: Use of memory after it is freed [unix.Malloc]
        usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, urbp->status);
                                                             ^~~~~~~~~~~~
Problem happens in this block of code

	c67x00_release_urb(c67x00, urb);
	usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00), urb);
	spin_unlock(&c67x00->lock);
	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, urbp->status);

In the call to c67x00_release_urb has this freeing of urbp

	urbp = urb->hcpriv;
	urb->hcpriv = NULL;
	list_del(&urbp->hep_node);
	kfree(urbp);

And so urbp is freed before usb_hcd_giveback_urb uses it as its 3rd
parameter.

Since all is required is the status, pass the status directly as is
done in c64x00_urb_dequeue

Fixes: e9b29ffc519b ("USB: add Cypress c67x00 OTG controller HCD driver")
Signed-off-by: Tom Rix <trix@redhat.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200708131243.24336-1-trix@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/c67x00/c67x00-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -500,7 +500,7 @@ c67x00_giveback_urb(struct c67x00_hcd *c
 	c67x00_release_urb(c67x00, urb);
 	usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00), urb);
 	spin_unlock(&c67x00->lock);
-	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, urbp->status);
+	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, status);
 	spin_lock(&c67x00->lock);
 }
 



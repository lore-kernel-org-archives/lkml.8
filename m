Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46877C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1750821531
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944928;
	bh=Wn50G7UV7hw+PsejYjxC4ngZXtE2dq+bWcMqBvPE7yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xLWfj99GicMZkKokBhs2GqVbEAs451lonK+qR7mrwCMAFFLt08bI+8uc3r6WMYDQI
	 E7KBdZA/fz7ZTs/di+/DYjrcwe5o4GvnH7gOUCxAM4p8xihnulDrlCZUpsWC9eMTuo
	 1BfxbEDSOKg6Lec1Ee9H89AsCe8/9VAPUwlENUgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392384AbgFWUmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403900AbgFWUmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3192053B;
        Tue, 23 Jun 2020 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944920;
        bh=Wn50G7UV7hw+PsejYjxC4ngZXtE2dq+bWcMqBvPE7yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSXHgqtygc2tnac2OAugIYC0h3/or/47oc/prQ89maLMo0ZzV1u+ap6rHafeHID4+
         B7Sp+D7ClbWzzCN9DfDkNSbYccqMx11tnbCaZ9qZoIkclCpB4kGVEY9o284/TwJRmT
         gYUkOp/fkcgxxeaTo8W0+jxfeytPMc/t3Atk+aqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 177/206] selinux: fix double free
Date:   Tue, 23 Jun 2020 21:58:25 +0200
Message-Id: <20200623195325.745737040@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit 65de50969a77509452ae590e9449b70a22b923bb upstream.

Clang's static analysis tool reports these double free memory errors.

security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
                        kfree(bnames[i]);
                        ^~~~~~~~~~~~~~~~
security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(bvalues);
        ^~~~~~~~~~~~~~

So improve the security_get_bools error handling by freeing these variables
and setting their return pointers to NULL and the return len to 0

Cc: stable@vger.kernel.org
Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2857,8 +2857,12 @@ err:
 	if (*names) {
 		for (i = 0; i < *len; i++)
 			kfree((*names)[i]);
+		kfree(*names);
 	}
 	kfree(*values);
+	*len = 0;
+	*names = NULL;
+	*values = NULL;
 	goto out;
 }
 



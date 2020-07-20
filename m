Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E013C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3722D02
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263161;
	bh=iUjDdbv2Y/n23mmUox5x/FmP5yHwFrC1cy3kp+kyGRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gLSK08utxkR/wIR4PUsvue+xT5l5cX/ufNI5QNULgx6ToeMCafyuwAQCDi/RzPZoz
	 VYP6qxJfnCksI/VBSlWkpUiZxLl9upZn5uU6GmuItrhCSVkaNjlGCaBLwqdi1kv8LP
	 oQMyNcnclDGkxHSz3Ukjo/Hsl71aqCayvk0YsMNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgGTQjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731026AbgGTPt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:49:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17E5206E9;
        Mon, 20 Jul 2020 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260169;
        bh=iUjDdbv2Y/n23mmUox5x/FmP5yHwFrC1cy3kp+kyGRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTmd17pbNFHqUmAWmrjgTGztzak7lYJsIsP2PRlu5bRXxeDEcPJg+GEGIJG/k7SIP
         jDqC4KU3+anQCLcGcvvE7LSin25MNGrh3V4Mu5VAlAyUmxOmnftsgA2ndfFMyC75pl
         /PSCPkGlWw4RzYYdbjZ1jtBnU24QqakocQIzq5dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 4.14 124/125] libceph: dont omit recovery_deletes in target_copy()
Date:   Mon, 20 Jul 2020 17:37:43 +0200
Message-Id: <20200720152809.061854551@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit 2f3fead62144002557f322c2a7c15e1255df0653 upstream.

Currently target_copy() is used only for sending linger pings, so
this doesn't come up, but generally omitting recovery_deletes can
result in unneeded resends (force_resend in calc_target()).

Fixes: ae78dd8139ce ("libceph: make RECOVERY_DELETES feature create a new interval")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -384,6 +384,7 @@ static void target_copy(struct ceph_osd_
 	dest->size = src->size;
 	dest->min_size = src->min_size;
 	dest->sort_bitwise = src->sort_bitwise;
+	dest->recovery_deletes = src->recovery_deletes;
 
 	dest->flags = src->flags;
 	dest->paused = src->paused;



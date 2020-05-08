Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7973FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BC824968
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941678;
	bh=kV98EsgCCVwfYGIGyknDDHj3jNejnuhthv1D6favVD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcLDrWe5HfA5b9yQlS3DwU2Pu+w0ekjcJ7AqkgCLtw0uEZNfW6GRg6WZct/cv+x5t
	 iilGHSFyS3WCTqQMFNihaCeMAs6HPT/jXAgxv1zhz3r7i6hVnVPGkmRLECaPG4KO1t
	 DmMzk+ilrewtW5TgINeAoxAHhemGWeb+rywWS4/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHMlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgEHMlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5B920731;
        Fri,  8 May 2020 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941670;
        bh=kV98EsgCCVwfYGIGyknDDHj3jNejnuhthv1D6favVD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+MZ0h6djnhrTDoT3EUln2aqdT45GDWCuJtXLkJJUL8S3Kvzjy2xXB2U4uA6Fpsk+
         RoerjEZa1cuvWqdwDXPF2wdERf04CenRQI8IVPkC86Js5bSvtR7rc1csYjGOTeQYSx
         tHF0CIvqqQfTuc4DTQuFF3+H1QbBw5FMRWLBMNuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Tayari <ilant@mellanox.com>,
        Rami Rosen <roszenrami@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.4 125/312] xfrm: Fix memory leak of aead algorithm name
Date:   Fri,  8 May 2020 14:31:56 +0200
Message-Id: <20200508123133.269293616@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilan Tayari <ilant@mellanox.com>

commit b588479358ce26f32138e0f0a7ab0678f8e3e601 upstream.

commit 1a6509d99122 ("[IPSEC]: Add support for combined mode algorithms")
introduced aead. The function attach_aead kmemdup()s the algorithm
name during xfrm_state_construct().
However this memory is never freed.
Implementation has since been slightly modified in
commit ee5c23176fcc ("xfrm: Clone states properly on migration")
without resolving this leak.
This patch adds a kfree() call for the aead algorithm name.

Fixes: 1a6509d99122 ("[IPSEC]: Add support for combined mode algorithms")
Signed-off-by: Ilan Tayari <ilant@mellanox.com>
Acked-by: Rami Rosen <roszenrami@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -332,6 +332,7 @@ static void xfrm_state_gc_destroy(struct
 {
 	tasklet_hrtimer_cancel(&x->mtimer);
 	del_timer_sync(&x->rtimer);
+	kfree(x->aead);
 	kfree(x->aalg);
 	kfree(x->ealg);
 	kfree(x->calg);



Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20157C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41E820782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=preining.info header.i=@preining.info header.b="CUjtkTjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHaGVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgHaGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:21:33 -0400
X-Greylist: delayed 2554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Aug 2020 23:21:33 PDT
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09307C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/i95vzyfWpS6eCxBQWhb4V8bmrV6UbLhK0Eq9Uxe4OM=; b=CUjtkTjr56lAd3Jnu11rV053IH
        rstccilescML/nx6Sif9taajQcv4lCmPxMK2j+9IhiKGofm2XjLN3qIlbY1EJYFoSJL+Q1CNpxCEe
        pnRKdnPPmfr4Kbqs4sP5QRDUhJMSllZrQcaRJIoodlP5tqoDcJ0HD5j1UHRmygn12WubVYWGiMFn8
        ZQpA4MSflVaOkqSZN71ujsoi4hK/tYlH2F2oAwEl+Txy9yqr6z0hHbvgHFErCEyqtqO9GfiQ0sSZN
        rQfwVRiX85ZnD5g8YuvcO4myXljy5jhYTWBMRGzogGna+FZ1NiH1fLtNWlUayn2Ih24NVmYKhsiFR
        C/PZjYKg==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1kCcWp-0000v7-Sx
        for linux-kernel@vger.kernel.org; Mon, 31 Aug 2020 05:38:52 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id C9797C3229A0; Mon, 31 Aug 2020 14:38:47 +0900 (JST)
Date:   Mon, 31 Aug 2020 14:38:47 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org
Subject: kernel hard lockups wit 5.9-rc{2,3}
Message-ID: <20200831053847.GA5022@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

(please Cc)

I am seeing hard lockups with 5.9-rc2 and -rc3, while 5.8.N (1,2,3,4,5)
work without any problems.

THe lockups are hard to debug, since not even Sysrq works anymore. The
screen freezes completely, no reaction. Ports are also dead, ssh into
the machine is not possible.

Hangs are repeatable, but not triggerable (at least I didn't find a
way). Last time I left the screen locked and went shopping to find it
locked up coming back. In total I got about 10 lock ups.

This is an Intel CPU with AMD 5700xt GPU, running Debian/unstable.

My feeling is somehow GPU related, but that might be a wide grasp.

Any suggestions how to debug this? The kernel logs after reboot are
empty.

Best

Norbert

--
PREINING Norbert                              https://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13

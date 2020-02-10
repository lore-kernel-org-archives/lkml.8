Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781D0C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4706C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="TpoMVyfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:04:14 -0500
Received: from srv1.deutnet.info ([116.203.153.70]:47854 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgBJKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:04:14 -0500
X-Greylist: delayed 2187 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 05:04:13 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-Id:Date:Subject:Cc:To:From:in-reply-to;
         bh=Vjm+UzdU4EFGRYU3esvZaagkde+R1fpPiensw/dr2Go=; b=TpoMVyfbdIvJ71K1ZGmEePIjz
        cjvj611qh2sD3SbSrxINVDva2ZX6mSueuJnz0q6XAPvqFJpyxOyJyPCiCTkao5hFmC5aXP3leIsaO
        aUR3KrsjGglA9l2nQ7HPYvplymwx8hH59FzIoeHE+bZVVo5ObED3tgQBchGu9Lvk0vA3hHGNO0kUN
        DA2BVeUc67xvKoB5ieaF+Q0PbRWCGrg7qIiRFdazgg/yOtUXodnqAWvKZEGwMU0rFxFYmV4VZP+RD
        DExP4FIffBu0XFHYC0+fj7HGvJnHrOyw79xaksjDPvPqf5oQhrwEWkrdpx8eGKDCZNLF5wn58i+CG
        mrTdBCOFA==;
Received: from [2001:bc8:3dc9::1] (helo=srv100.deutnet.info)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j15Lw-0007fi-2U; Mon, 10 Feb 2020 10:27:40 +0100
Received: from agriveaux by srv100.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j15Lv-00DSou-NC; Mon, 10 Feb 2020 10:27:39 +0100
From:   agriveaux@deutnet.info
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        agriveaux@deutnet.info
Subject: ARM: dts: sun5i: Add dts for inet86v_rev2
Date:   Mon, 10 Feb 2020 10:27:35 +0100
Message-Id: <20200210092736.3208998-1-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM: dts: sun5i: Add dts for inet86v_rev2

Add Inet 86V Rev 2 support, based upon Inet 86VS.

Missing things:
- Accelerometer (MXC6225X)
- Touchpanel (Sitronix SL1536)
- Nand (29F32G08CBACA)
- Camera (HCWY0308)



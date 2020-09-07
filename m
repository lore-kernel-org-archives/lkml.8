Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AEDC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDC020738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vCF4/+S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgIGL7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:59:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48520 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgIGLzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:55:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087BsUxr038164;
        Mon, 7 Sep 2020 06:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599479670;
        bh=7+EDL59N1vzKLk7OP38P/jtVYpuOIQC7iGq1qPqi3KM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vCF4/+S4z/SpKTh7ZZX+AH2G+EDLch2wMtvjYZY0bjt3/Bpft5C8anLlxem6mjIc+
         Xj470AzvZIXI8SqGGGCaTQc6aq3OA4p8s/zbgg5xQpeXvroiLyQXeVwMtEI6+v1taI
         upitOwTBzsHH0YGm8Vp+wY3vMlDtPiYfVUWOYFK4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087BsU79089613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 06:54:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 06:54:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 06:54:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087BsU7f084829;
        Mon, 7 Sep 2020 06:54:30 -0500
Date:   Mon, 7 Sep 2020 06:54:30 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: Re: [PATCH V2 0/8] arm64: dts: ti: k3-*: Squash up
 node_name_chars_strict warnings + hex usage
Message-ID: <20200907115430.rmhaubsyho6pgszh@akan>
References: <20200901223059.14801-1-nm@ti.com>
 <20200903130015.21361-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903130015.21361-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08:00-20200903, Nishanth Menon wrote:
> Hi,
> 
> This is a respin of v2 of the series posted as [1].
> 
> As part of this cleanup, I ran a cross check of nodes that are
> part of K3 as of right now, Vs what is "generic" definition as per 0.3
> dt specification [2].
> 
> Changes in v2:
> - Based off 20200903
> - Picked up Acks and reviewed-by from previous versions (please comment
>   if you disagree).
> - Dropped tsadc rename [3] based on review
> - Added 2 patches to fixup hexadecimal usage caught as part of review
> - few additional fixups.
I have applied the following to branch ti-k3-next on [1].

[1/8] arm64: dts: ti: k3-j721e: Use lower case hexadecimal
      commit: 1aedefe13ba263d0d7d1cfbb38aadebbd5bab34e
[2/8] arm64: dts: ti: k3-am65-main: Use lower case hexadecimal
      commit: 05e393c596c4495d79f0cbeacb0f0a0e0b6f89d5
[3/8] arm64: dts: ti: k3-am65*: Use generic gpio for node names
      commit: 91e5f404e42bc189bb0e447d30041de737ad24bf
[4/8] arm64: dts: ti: k3-am65*: Use generic clock for syscon clock names
      commit: 86e67b591e6d993d98567143451883a5618c196e
[5/8] arm64: dts: ti: k3-*: Use generic pinctrl for node names
      commit: dcccf77067e4274953e8944d9730bb7ae2964c28
[6/8] arm64: dts: ti: k3-am65-base-board Use generic camera for node name instead of ov5640
      commit: 4c19fb9ce266561ab122880a02e873ee8c3668e4
[7/8] arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for node name
      commit: 9a8ecd414322ceb377cecb4795e3f3d7d7020952
[8/8] arm64: dts: ti: k3-*: Fix up node_name_chars_strict warnings
      commit: e5c956c4f36cdd59e775f2285af9a1683374c5a5

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

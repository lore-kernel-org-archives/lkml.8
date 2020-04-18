Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BACC38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C9214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgDRJ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:56:19 -0400
Received: from outgoing15.flk.host-h.net ([197.242.87.49]:54181 "EHLO
        outgoing15.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgDRJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:56:19 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam4-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1jPkCl-0003zf-DK; Sat, 18 Apr 2020 11:56:09 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1jPkCi-0004Rl-1x; Sat, 18 Apr 2020 11:56:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 18 Apr 2020 11:56:03 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/3] ARM: dts: rockchip: add rga node for rk322x
Organization: Rising Edge Consulting (Pty) Ltd.
In-Reply-To: <3593382.iQIKm1rSL1@phil>
References: <be4f2c802a64562cbab629abc82dd7d228a1a747.1580768038.git.justin.swartz@risingedge.co.za>
 <bf3a2b97-4a24-e9f0-599b-4731cc94a067@gmail.com> <3593382.iQIKm1rSL1@phil>
Message-ID: <b77422198df7c285d824086131371284@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0c6d8zDasFm/nDPEg7mmhmypSDasLI4SayDByyq9LIhVHYm7b54MofsP
 P7P4HLmGW0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K9N8RgbelEU3z4k5cN6Fx7gF4
 IxdPpqe03Ke3W55CSgGipX77xU2/OO3DievkIHLPfxKns5/jA/jb0AB/j1tpH5/cd7uPDhKhWGZM
 n/d4/07rfhJgg4j+T1FAIbCdkgBZfCzdNGNoLjYW00m5NbCHvBeT5wQmTgARe2GQxmQnRbjM24OD
 2qGt6TVUNM5e7f/l0+1oQ9dbW2b4wUcsVhgjow+WYwXa7GcGa/wA/cDlM+P6m886XHyIQD/p5Il5
 tdzxoYPWT1EPgWcSbCHk8ujeSnbOj+JOCV+/R+gbydGJHww7+VDP+4gu9MM0P8MwqJbtWZ+mBFw9
 wbDfCbgPXUhoanzj5ZBolYt3lOJtwiLNmx2pKRVnMrHZos0/M6pU0hfymyBYx1qtDaSiXo0xo2LM
 mUL1Z4FithJQbhPXqfOZuDjg+BfHWJbc41rbg4WcJeyvwlzK01+6b05+4Lv/pcVBKbSIAO62+V2p
 H7ZPpEG6bBjHHjcTvuwcWprgtdAKuxeqzv2BE9ufKeYEt2P7UPu8FYh90mU5ltygBte98Lr3o1L6
 PRFBPTGx1Ut6/5oByZyEBYORon1HyENyISfTHOtpKTVgw9yWWIEWQ/ZfK1AKScQjMOukFP3P4kFf
 oa8491sqVkDREtHj5EdIfRWQU1iQcN9fxN2oReTDHAyOynaY0CkMg0bLHYOUd2k/FP4GZ8aMLaoD
 dgTYDNJYOqlsNiYINBaq6FA+N87m5dPuP1bu7yrY5Qx4fJOk03R5fJtf/Dv/oTkmxux7nkDlcqo4
 0fvNe6qOBRNkqxqaHyOluuELaV/iA1tw7Cg2iBBUqc+VnwxMgxBYG44cJsHiAJUj2A0ZGRjKipVB
 PsGEs9WdtZIsKKJKTq/OlMObqOptAlx2sHDvpbjylqmC5Mk1B2fFLLRq9AM3V/uXrKlq++rODlln
 NUDihjA708Lg3Y2gXyaf+rIt2G7p5aZhaonSvSgNc8r+HETXd4ACBhnKCgIjlPF0gJGMaV6CJSmg
 U8pftbLkxChMcbUnuWly1fKGgusHp5Yiz+nQvc0qoAtxzv3f8GtQSFsBkqIPpf8+LdgXwjxPOBMx
 sdiFdDCFcQsgFkL4G7F2Av2/exi5Ms9gyaqIruy7eYaKVAcye5FPIQnr8/7he/iizki9qqiuW3Bk
 5C+gdmOiVTCThXc0JQjVu0w41Mrtp0JBN8rqB+cgngTSjDAt8hSY
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan, Heiko,

On 2020-04-18 11:49, Heiko Stuebner wrote:

> Am Samstag, 18. April 2020, 11:15:27 CEST schrieb Johan Jonker:
> 
>> Hi Justin, Heiko,
>> 
>> In the discussion about "rockchip,px30-rga" it was mentioned that:
>> "no status for soc internal components without any board-specifics".
>> The binding is in mainline, but the dts node is missing I think.
>> Should this also be changed?
> 
> yep, drop the status disabled from the dtsi and that then results
> in not needing the board-level enablement
> 
> (background: rga is a simple mem2mem device without any
> board-specific hooks)

Shall I submit version 5 of this patch series?

> Johan
> 
> +&rga {
> +    status = "okay";
> +};
> +
> 
> Add a node to define the presence of RGA, a 2D raster
> graphic acceleration unit.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
> arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk322x.dtsi 
> b/arch/arm/boot/dts/rk322x.dtsi
> index 340ed6ccb..29d50bebc 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -621,6 +621,17 @@
> status = "disabled";
> };
> 
> +    rga: rga@20060000 {
> +        compatible = "rockchip,rk3228-rga", "rockchip,rk3288-rga";
> +        reg = <0x20060000 0x1000>;
> +        interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
> +        clock-names = "aclk", "hclk", "sclk";
> +        resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru 
> SRST_RGA_H>;
> +        reset-names = "core", "axi", "ahb";
> +        status = "disabled";
> remove?
> 
> +    };
> +
> iep_mmu: iommu@20070800 {
> compatible = "rockchip,iommu";
> reg = <0x20070800 0x100>;

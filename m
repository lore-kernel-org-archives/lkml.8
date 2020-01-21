Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E5C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A224125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgAUVpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:45:34 -0500
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:48971 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:45:34 -0500
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1iu1Ku-0001yg-7h; Tue, 21 Jan 2020 23:45:25 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1iu1Kt-0004Vc-Ev; Tue, 21 Jan 2020 23:45:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Jan 2020 23:45:23 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: rockchip: add rga node for rk322x
Organization: Rising Edge Consulting (Pty) Ltd.
In-Reply-To: <7d85210b-e554-d875-0615-c2e93a264b5b@gmail.com>
References: <20200121201146.18038-2-justin.swartz@risingedge.co.za>
 <7d85210b-e554-d875-0615-c2e93a264b5b@gmail.com>
Message-ID: <d2661596ca26a4b8041a9fac7ee61593@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fKZ8wcD78QFAaYhvfMzLIKpSDasLI4SayDByyq9LIhVIjj3L/PxiS7u
 W7QBiFbhO0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K9N8RgbelEU3z4k5cN6Fx7gF4
 IxdPpqe03Ke3W55CSgGipX77xU2/OO3DievkIHLPfxKns5/jA/jb0AB/j1tpH5/cd7uPDhKhWGZM
 n/d4/07rfhJgg4j+T1FAIbCdkgBZfCzdNGNoLjYW00m5NbCHvBeT5wQmTgARe2GQxmQnRbjM24OD
 2qGt6TVUNM5e7f/l8Qrx+iUTedVmWsVl8JiUwdcWVa3aRmI0WtgQJ6NhkUG1fr3z7O1ewfolpqk2
 9AXTfJkhAT2xwGkQ4rYFSsz8y8l2BJ9SVPTxAsXbMIYTBf07+VDP+4gu9MM0P8MwqJbtxxmkpCtD
 oIUeLHY6xjiNGnzj5ZBolYt3lOJtwiLNmx2pKRVnMrHZos0/M6pU0hfymyBYx1qtDaSiXo0xo2LM
 mUL1Z4FithJQbhPXqfOZuDjnjAAPbecZ+Mi6985HXYGYwlzK01+6b05+4Lv/pcVBKbSIAO62+V2p
 H7ZPpEG6bBjHHjcTvuwcWprgtdAKuxeqzv2BE9ufKeYEt2P7UPu8FYh90mU5ltygBte98Lr3o1L6
 PRFBPTGx1Ut6/5oByZyEBYORon1HyENyISfTHOtpKTVgw9yWWIEWQ/ZfK1AKScQjMOukFP3P4kFf
 oa8491sqVkDREtHj5EdIfRWQU1iQcN9fxN2oReTDHAyOynaY0CkMg0bLHYOUd2k/FP4GZ8aMLaoD
 dgTYDNJYOqlsNiYINBaq6FA+N87m5dPuP1bu7yrY5Qx4fJOk03R5fJtf/Dv/oTkmxux7nkDlcqo4
 0fvNe6qOBRNkqxqaHyOluuELaV8fK+PYMsT3XdL8lKcxk4qNMd+wV+SvLBUi20FCqfORF1Uwgn3x
 dHPlIKTREtTpKWlKTq/OlMObqOptAlx2sHDvpbjylqmC5Mk1B2fFLLRq9AM3V/uXrKlq++rODlln
 NUDihjA708Lg3Y2gXyaf+rIt2G7p5aZhaonSvSgNc8r+HPe3kEEhe4Xl2ceCgkDvM9qMaV6CJSmg
 U8pftbLkxChMcbUnuWly1fKGgusHp5Yiz+nQvc0qoAtxzv3f8GtQSFsBkqIPpf8+LdgXwjxPOBMx
 sdiFdDCFcQsgFkL4G7F2Av2/exi5Ms9gyaqIruy7eYaKVAcye5FPIQnr8/7he/iizki9qqiuW3Bk
 5C+gdmOiVTCThXc0JQjVu0w41Mrtp0JBN8rqB+cgngTSjDAt8hSY
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2020-01-21 23:34, Johan Jonker wrote:

> Hi Justin,
> 
> rga is now inserted above vpu_mmu.
> Please check the address.
> 
> rga:       rga@20060000 {
> vpu_mmu: iommu@20020800 {
> 
> Should go between vop_mmu and iep_mmu.
> 
> vop_mmu: iommu@20053f00 {
> rga:       rga@20060000 {
> iep_mmu: iommu@20070800 {

Thanks!

>> Add a node to define the presence of RGA, a 2D raster graphic
>> acceleration unit.
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>> arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/rk322x.dtsi 
>> b/arch/arm/boot/dts/rk322x.dtsi
>> index 340ed6ccb..efa733207 100644
>> --- a/arch/arm/boot/dts/rk322x.dtsi
>> +++ b/arch/arm/boot/dts/rk322x.dtsi
>> @@ -566,6 +566,17 @@
>> status = "disabled";
>> };
>> 
>> +    rga: rga@20060000 {
>> +        compatible = "rockchip,rk3228-rga", "rockchip,rk3288-rga";
>> +        reg = <0x20060000 0x1000>;
>> +        interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
>> +        clock-names = "aclk", "hclk", "sclk";
>> +        resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru 
>> SRST_RGA_H>;
>> +        reset-names = "core", "axi", "ahb";
>> +        status = "disabled";
>> +    };
>> +
>> vpu_mmu: iommu@20020800 {
>> compatible = "rockchip,iommu";
>> reg = <0x20020800 0x100>;
>> --
>> 2.11.0

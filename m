Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B2CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608922070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="z00tIkug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgG1H15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:27:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34080 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgG1H15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:27:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S7I0mM015172;
        Tue, 28 Jul 2020 09:27:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=L908e2AdQSAptw2MG0+5KEEyg20P0DnrpSzY3TXAojs=;
 b=z00tIkugcratI9e5e77HQjJo3ixY/oHxNREc9N4lcN5UzKrNzBPI0m9+aTks0zETaszu
 ydeTDMAExij1wXWKKUz37quocYSk3p4XsbdmC6mjXqaPmDRf3BLHDlIxBJtXbNb6p3g4
 MUvyqlAM4iumBCxTPVJCOwPPiE543J63KLul1mzH5kvL2qrE55a1VjH2zUMPiPBbYec3
 M4AefGRuV4Gfh6JoBihACujluFq8q3hQEWNIUI7CATa5oSytZj/uI5g6yJZ4gJ6NP2P2
 hwk2d5XcOkLrrtoEzd/qxVLNBz6MGGn3XASQ3e6HcM10B7VT9Q7cSqCthJkSl7SYe3Zr vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gbmg4q00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 09:27:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8562A100034;
        Tue, 28 Jul 2020 09:27:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7063121F0BF;
        Tue, 28 Jul 2020 09:27:38 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 09:27:37 +0200
Subject: Re: [PATCH v4 3/3] usb: dwc2: don't use ID/Vbus detection if
 usb-role-switch on STM32MP15 SoCs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
References: <20200727092346.19780-1-amelie.delaunay@st.com>
 <20200727092346.19780-4-amelie.delaunay@st.com>
 <CAFBinCCXuUC4PHgrobYjj=yjA3Tz73Wwx0KWz+B6PfCw_OSi_w@mail.gmail.com>
 <CAHp75Ve75d+K87cokb4YYgim_wU0gTidGuiPs3BmohRKfTh5gA@mail.gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <19ba2fe3-56d1-32a9-3897-27a36ab58c2c@st.com>
Date:   Tue, 28 Jul 2020 09:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve75d+K87cokb4YYgim_wU0gTidGuiPs3BmohRKfTh5gA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_01:2020-07-27,2020-07-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/27/20 9:44 PM, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 10:04 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> On Mon, Jul 27, 2020 at 11:23 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> > -       p->activate_stm_id_vb_detection = true;
>> > +       p->activate_stm_id_vb_detection =
>> > +               !of_property_read_bool(np, "usb-role-switch");
>> the rest of params.c uses device_property_read_* instead of of_read_property_*
>> I thought I'd mention it so you can decide yourself whether this is
>> fine or needs to be changed
> 
> Better to change and leave all on one line.
> 

Thank you both for your review. I'll change it in upcoming v5. I'm still 
not used to exceed the 80 columns :)

Regards,
Amelie

> -- 
> With Best Regards,
> Andy Shevchenko

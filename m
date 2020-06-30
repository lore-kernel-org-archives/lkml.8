Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30FAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B403F20775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgF3Jjo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:39:44 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44020 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbgF3Jjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EB070607400F;
        Tue, 30 Jun 2020 11:39:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qd6xqziz9yTM; Tue, 30 Jun 2020 11:39:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 786BA6074029;
        Tue, 30 Jun 2020 11:39:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UNVw8191GTR5; Tue, 30 Jun 2020 11:39:37 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 423E0607400F;
        Tue, 30 Jun 2020 11:39:37 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:39:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, arnd@linaro.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Marek Vasut <marex@denx.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Message-ID: <1839269888.74591.1593509977137.JavaMail.zimbra@nod.at>
In-Reply-To: <e30abadc-83c0-f010-be36-fe8d14c4aea9@st.com>
References: <1591975362-22009-1-git-send-email-christophe.kerello@st.com> <1591975362-22009-5-git-send-email-christophe.kerello@st.com> <CAFLxGvzfh1Qa_gM9bZAxaoCbO6xCoNdaPN=Ea20Up_zPVgjugw@mail.gmail.com> <e30abadc-83c0-f010-be36-fe8d14c4aea9@st.com>
Subject: Re: [PATCH v5 4/6] memory: stm32-fmc2-ebi: add STM32 FMC2 EBI
 controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
Thread-Index: IyChESkmAt61iUEj3iffmldxiXkByg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Christophe Kerello" <christophe.kerello@st.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "Rob Herring" <robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, arnd@linaro.org, "Alexandre Torgue"
> <alexandre.torgue@st.com>, "Marek Vasut" <marex@denx.de>, "devicetree" <devicetree@vger.kernel.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.org>, linux-stm32@st-md-mailman.stormreply.com
> Gesendet: Dienstag, 30. Juni 2020 11:35:38
> Betreff: Re: [PATCH v5 4/6] memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver

> Hi Richard,
> 
> On 6/30/20 11:13 AM, Richard Weinberger wrote:
>> On Fri, Jun 12, 2020 at 5:24 PM Christophe Kerello
>> <christophe.kerello@st.com> wrote:
>>>
>>> The driver adds the support for the STMicroelectronics FMC2 EBI controller
>>> found on STM32MP SOCs.
>>>
>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>> ---
>>> +       if (!IS_ERR(rstc)) {
>>> +               reset_control_assert(rstc);
>>> +               reset_control_deassert(rstc);
>> 
>> Shouldn't there be a small delay between assert and deassert?
>> Other than that the code looks good to me.
>> 
> 
> Even if I have currently not met any issue, I will add a udelay(2) to be
> safe. It will be part of v6.

Well, if it works and you are sure, please go for it. Like I said, I'm no expert in
this.
I just noticed that other users add a delay and wondered.

Thanks,
//richard

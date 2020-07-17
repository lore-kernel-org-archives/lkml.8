Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA8C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B23F2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGQJh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:37:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55434 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:37:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9BB002A508E
Subject: Re: [RESEND RESEND PATCH] arm/arm64: defconfig: Update configs to use
 the new CROS_EC options
To:     Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Kukjin Kim <kgene@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Bastien Nocera <hadess@hadess.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <maxime@cerno.tech>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20200305111047.147355-1-enric.balletbo@collabora.com>
 <CAFqH_52LhfV9AsnPRZi_ZPsgYX8WrUrKEsV-E7VHOw3ZZtHd-w@mail.gmail.com>
 <CAK8P3a0ScHe+ErEZr-x4Sj=3Yz7cppKDcemXemvwXMbPh-RVMQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2c7a9b5f-968b-38a2-3f67-f731a8617e09@collabora.com>
Date:   Fri, 17 Jul 2020 11:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0ScHe+ErEZr-x4Sj=3Yz7cppKDcemXemvwXMbPh-RVMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 17/7/20 8:59, Arnd Bergmann wrote:
> On Wed, Jul 15, 2020 at 11:31 PM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
>> dia dj., 5 de març 2020 a les 12:11:
>>>
>>> We refactored the CrOS EC drivers moving part of the code from the MFD
>>> subsystem to the platform chrome subsystem. During this change we needed
>>> to rename some config options, so, update the defconfigs accordingly.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>
>> A gentle ping. I'd like to land this if is possible because that way I
>> can remove some legacy code in platform/chrome subsystem.
>>
>> Thanks,
>>   Enric
>>
>>> Dear all,
>>>
>>> This is a resend of a resend patch [3]. In some previous discussions
>>> maintainers would prefer to have this merged through the arm-soc tree
>>> but wasn't merged yet and I forget to ping again, hence, sending a new
>>> resend.
> 
> I've merged it into the arm/defconfig branch of the soc tree now.
> If you have future platform specific changes to the defconfig files,
> please just add soc@kernel.org to the recipients to get the patch
> into patchwork.
> 

Many thanks! I'll take into account this next time.

>      Arnd
> 

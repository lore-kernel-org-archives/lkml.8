Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369ECC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123B722B43
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0F5Yqp1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgG1HxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:53:11 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19363 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgG1HxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595922789; x=1627458789;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=NCgo8E7J6iYnLWIERMFlSYi/bk1Up+lw+01foO6NU20=;
  b=0F5Yqp1jAklmivz/vNCKssuAbulqG7Z5+ZwT++553FjkVKlxRM42VvRv
   2mETpFRaT4jG0Wmf9czmkdqraMszBj++BkvpzOMNVBffvKUi0hRZB/Vw5
   +Ylonkwc8mpHCBm3oRM4UVMCK7fGrJ5Zl89piusxqFIy7w2TF48YinAGD
   zD4PxeZih6pRGUNqJByh1hJIQ5VzOmOkpwbZyzxjvIx+Iali3Nx+3mJWe
   NSpunRhOblc0SZPdfTD2TDZ/dJPSjoVjubPigmMyFcaBxX7D4n7BtjTX+
   9ZlVVTx/GM4iYF5ws/NqUpD+aA/gtGEkKp3lN0Ap+zUqJfEoBwuEjbncx
   g==;
IronPort-SDR: 9hMqYVRNZCWWZDVzdqyMhx4ASsF6C1zwZ4sXT7yVaHqmywv54cblCX2voGCnD8re13oAqJ08Ed
 LiY1z0hRApHXgpfJew1Imemb3AzvreYokpHkAbR+VKhgeqeBtaV3C5kuc5G0KHQu0yWvuNHdnz
 EvmDv0100X8MnhDXlC8zs6CDB041m+WlxaSlKlEORLzuKjDjB2wwKEKWrcHBEYw5+91RnnIUV4
 70ftEbXs/ahrXIFMInHaq40lA6jaRgh5c8jnDTQWMlXeArIlfL0tphuPza7XGjCXyix3M6ulN0
 SqA=
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="81493886"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2020 00:53:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 00:52:21 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 28 Jul 2020 00:53:06 -0700
References: <20200727112236.8199-1-lars.povlsen@microchip.com> <CAK8P3a3WJTKH7-KGgp7CuhZv_wtrtY1k+1LEL-62_Rj+wqbrGQ@mail.gmail.com> <159587873833.1360974.11729154337431621644@swboyd.mtv.corp.google.com> <CAK8P3a27u7UkjGJ32KsRp02FoF34mKW0gRUsms0+YBkxy+L4Gg@mail.gmail.com> <159588781925.1360974.3928941757935200801@swboyd.mtv.corp.google.com>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Stephen Boyd <sboyd@kernel.org>
List-Id: <soc.lore.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH linux-next] clk: sparx5: Review changes
In-Reply-To: <159588781925.1360974.3928941757935200801@swboyd.mtv.corp.google.com>
Date:   Tue, 28 Jul 2020 09:53:04 +0200
Message-ID: <87tuxsf53z.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen Boyd writes:

> Quoting Arnd Bergmann (2020-07-27 13:11:49)
>> On Mon, Jul 27, 2020 at 9:39 PM Stephen Boyd <sboyd@kernel.org> wrote:
>> >
>> > Why was the clk driver merged to linux-next outside of the clk tree? Was
>> > there some sort of dependency?
>>
>> I merged the entire series of the base platform support along with
>> a few core drivers. I had asked for the series to be submitted to
>> soc@kernel.org after all parts had been reviewed, but I missed that
>> the clk driver was still missing maintainer review (I saw you had
>> reviewed some patches, but apparently that was just the binding,
>> not the driver).
>>
>> I rebased the 'arm/newsoc' branch the other day to fix another mistake,
>> so if you prefer, I can rebase it again and drop the clk driver or
>> all the sparx5 patches.
>>
>
> Yes, please just drop the clk driver and I can pick it up for the next
> merge window from the list and all the fixes can be rolled into one
> patch.

Sorry for all the commotion!

With Stephen's comments I assume I don't have to submit anything new,
at least not right now.

Otherwise, please let me know.

Cheers,

-- 
Lars Povlsen,
Microchip

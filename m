Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A811C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4D8207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgANJ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:56:36 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:56085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgANJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:56:36 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N8oKc-1jluEe0XlG-015mbQ for <linux-kernel@vger.kernel.org>; Tue, 14 Jan
 2020 10:56:34 +0100
Received: by mail-qt1-f175.google.com with SMTP id d5so11924517qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:56:33 -0800 (PST)
X-Gm-Message-State: APjAAAVVgJuPfNGDRo/rbwvWjfwLGJLf/bN8Z4fNYz0x02oeOkGN6gmj
        s0iWXzCr306t0usIywE6xB7mucbAaao6I+HT6YU=
X-Google-Smtp-Source: APXvYqzAj8PJkE5/uF+NxfL3FE7u4OmKH2n+jc3UkRoq4QVztBCleDWEbe6N30Yqnyj3pc1ZnGojUB2ACXN7L/Bma0w=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr2796033qtm.18.1578995792883;
 Tue, 14 Jan 2020 01:56:32 -0800 (PST)
MIME-Version: 1.0
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7> <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
 <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
In-Reply-To: <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 10:56:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
Message-ID: <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/IAcJ5FhWssWRHpFA64P7T6errsjSWrWtyY0h5fCKwZlnu2UWOp
 f3SYhoGwpM8j02Gn2cGDuBxscZk2S7lRirvjdZLFhDVfK9p11J16HbEf5vvFUjnn0VlNRaB
 ZO2o3aoh5Bp6kCzu0W+FXI4b2qut6HRBNUVJrpD4c58mQvIoBLZm06RkJcW26YhL868Je3E
 mmZ2tzkVWmHROJCNFv36w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dI5qwZpmHjM=:6i0RJZ0RhinXnDld/aGNWi
 gphK6S5EWHqk/aYRbtKswEj3FPUVqounI16Q7Qp+AWjuuPbwiCIZtLGWAFW1vmtqX6Xr9vBfX
 tJZd7UaOk5fDJMeJ5I6Hz7yHVIx03srFYYOkbob7sPLIg4EHgYoM592szc7XSQmGQ9TVRRC9W
 rgAOS8MIf7/8WaHRpI8s3zT0lEWwSV2JdbVOGbxIbXH8pSHub6RfKvd2tGlj0vo3ggeAftzmL
 16wvVz8/gF6T8MtMzaNXxOnfKj4CIk7XfW0PBRIaN7FPd5kllIdjaw8MKS3IBCzfnpzvjokKJ
 SL1xD2dxXzsf3KBhR/l4atPbR15Srki6gSSOFhvlOfF3B/sG+StrQes6vC6EB61ZiJngHFFYj
 7Pxa3tqkH0/6nbEq7Wn4jSyG2P1grLu3PbiAes/SVlwpIhM8i0R5j63JOSqztrF24P8q5VGLd
 g5ZBKEIyyV0ad7DHemXWpLcvrQJGhK/mOqaFHVYNVGOBJLdPSGXPx1EwnOxjJULRI8ko+0Eym
 iOeIcWkBw3Gwuq+oSd236a993nxHjCahUoJ8UwDespT7Of690X6RH+F+lR6rcWc0WQuI+OnWP
 NJobjOC5Ekodbw1rAgsdMUT4toCboP6Ev499X5u940DG4r07L8PtWfFJwHJz8dYX0ITPUr3Hk
 eGCIdbgc01+HVPPpvUuQ8XWL1phvblsjKazR6EMLhezIX/rAcUrVEj2VJozSGQ1YprCXUeLuV
 Oq6zBrroFlDvna+yVcNbOzZGuY8TlHCtIDfnODjOkGo/ck9hekzwA5daywehHqYYbebg9PlO3
 HqwBe/mmGNhkbajJr0yJh2LrBvEtHNfhMA4JHdRV3gUr6qBN3U+i66QXdbO/iDjhiQlPCuQp2
 TKJYO2EKith2TVp19iXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 13-01-20, 12:36, Arnd Bergmann wrote:
> > On Mon, Jan 13, 2020 at 7:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > To answer all three, what I meant is that the payload pointer appears
> > to be transport specific and
>
> I am not sure if I understood the below statement properly. Is there
> something missing from it ?
>
> > should not be part of the common
> > structure if there is generic way to access it.
>
> The scmi protocol requires a block of shared memory which is
> represented by struct scmi_shared_mem, and payload is this memory
> block itself. This block of memory is accessed throughout driver.c
> file using ioread/write commands. If payload is transport specific, so
> will be those accesses, isn't it ? Are you suggesting to move all this
> to mailbox.c (the transport specific file) instead ? I am sorry, but I
> am not able to understand how exactly you want me to reorder code here
> :(

My point was that you cannot mix __iomem accesses with pointer
accesses. As I understood it, the current version uses a pointer to a
hardware mailbox with structured data, so you have to use ioremap()
to get a token you can pass into ioread(), but (some of) the new
transport types would just be backed by regular RAM, on which this
is not a well-defined operation and you have to use memremap()
and memcpy() instead.

     Arnd

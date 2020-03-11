Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92F9C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B533120736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yv+XHTZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgCKTaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:30:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54784 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbgCKTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:30:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id np16so1443952pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7jvPo26ezcO1RKTjjuzQtvWXceMFdaSOSRWJmiZNJw4=;
        b=Yv+XHTZxeivkpKYFS+alaKj25StyZXhjpaEvIM20FT59Armo/Y11KS5kf7Ukm6FRxE
         aNyrNRNgqWww+6nZUc0tPxUU5cxB1zKrxUPf5oeucmBQZLPVpkQP5ItzpynvF6HamvWd
         3IDQFCc+4AsEfxBLEkY+G0+3c2S66TckVU5wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7jvPo26ezcO1RKTjjuzQtvWXceMFdaSOSRWJmiZNJw4=;
        b=WBceZSImwpBTCJcb1dHfp/6or7AdpgFqxESyt9ZHpWMEWEcoNYKXQleAf/Vq/S/mPi
         HP4nMWL4bRhlUG6oXp0Snh01ortrBKAFEkKV/ylVIII5n1Ual/LwbeKzNP8hy8mISO5M
         1Hi0/VBK9DDLr5aXnz41zguD87SqrDiyRBf3dXDCLDB6JThXK31DLPkRyChkHeVrEjFQ
         1T5xELZ2wEY1iloOe6+rmufkxWvVEiwJvuDKTZ2ls/23V51FUuazlLLTGZ0vhM4uU5Le
         gLr11lq3eXgS9yE38yRgaKGX7o572kPTTUvySruSTGwAhAGdGBPnPrYG1QV8Rhkp5PfW
         otCA==
X-Gm-Message-State: ANhLgQ0WwxZ1AqhSpdVjiTPj0B1/Zc3ekH9e2Ac7TfphsUnHYJp9ekAu
        sWhXWwJ1TYFckFaBZwgl92wblg==
X-Google-Smtp-Source: ADFU+vsl1B2jsBIA61MIvGcLVS9m5leSfAcQAJBDDh7csgRmedNFz+G7+q5Rbch9iWzDlV7BA8gUmw==
X-Received: by 2002:a17:902:d70e:: with SMTP id w14mr4256073ply.181.1583955003895;
        Wed, 11 Mar 2020 12:30:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm51941969pfo.102.2020.03.11.12.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:30:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200311161726.GA144492@google.com>
References: <20200306235951.214678-1-dianders@chromium.org> <20200306155707.RFT.1.I1b754137e8089e46cf33fc2ea270734ec3847ec4@changeid> <85758e97-8c0c-5c4e-24ad-d3e8b2b01d3c@codeaurora.org> <CAD=FV=X649r8qrNRZSezUBEuJbt0oZg6VBweAGjEhxOPp0zf2w@mail.gmail.com> <20200311161726.GA144492@google.com>
Subject: Re: [RFT PATCH 1/9] drivers: qcom: rpmh-rsc: Clean code reading/writing regs/cmds
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Date:   Wed, 11 Mar 2020 12:30:02 -0700
Message-ID: <158395500244.149997.1358582842144222001@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2020-03-11 09:17:26)
> Hi,
>=20
> On Wed, Mar 11, 2020 at 08:03:27AM -0700, Doug Anderson wrote:
> > Hi,
> >=20
> > On Wed, Mar 11, 2020 at 1:47 AM Maulik Shah <mkshah@codeaurora.org> wro=
te:
> > >
> > > Hi,
> > >
> > > On 3/7/2020 5:29 AM, Douglas Anderson wrote:
> > > > This patch makes two changes, both of which should be no-ops:
> > > >
> > > > 1. Make read_tcs_reg() / read_tcs_cmd() symmetric to write_tcs_reg(=
) /
> > > >    write_tcs_cmd().
> > >
> > > i agree that there are two different write function doing same thing =
except last addition (RSC_DRV_CMD_OFFSET * cmd_id)
> > >
> > > can you please rename write_tcs_cmd() to write_tcs_reg(), add above o=
peration in it, and then remove existing write_tcs_reg().
> > > this way we have only one read and one write function.
> > >
> > > so at the end we will two function as,
> > >
> > > static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int=
 cmd_id)
> > > {
> > >         return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET=
 * tcs_id +
> > >                              RSC_DRV_CMD_OFFSET * cmd_id);
> > > }
> > >
> > > static void write_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, i=
nt cmd_id,
> > >                           u32 data)
> > > {
> > >         writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET=
 * tcs_id +
> > >                        RSC_DRV_CMD_OFFSET * cmd_id);
> > > }
> >=20
> > I can if you insist and this is still better than the existing
> > (inconsistent) code.
> >=20
> > ...but I still feel that having two functions adds value here.
> >=20
> >=20
> > Anyone else who is CCed want to weigh in and tie break?
>=20
> I agree with Doug, having two functions makes the code that calls them
> clearer. It makes it evident when a command is read/written and doesn't r=
equire
> a useless extra parameter when accessing a non-command register.

Me too! In fact, I asked for this when this driver was introduced and I
was half-ignored[1]. Making sure we never have to pass 0 to one of these
functions should be a goal.

From two years ago:
>
> Is m the type of TCS (sleep, active, wake) and n is just an offset?
> Maybe you can replace m with 'tcs_type' and n with 'index' or 'i' or
> 'offset'. And then don't use this function to write the random TCS
> registers that don't have to do with the TCS command slots? I see
> various places where there are things like:
>=20
> > +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
> > +       write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complet=
e);
> > +       write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
>=20
> And 'n' is 0, meaning you rely on that 0 killing that last part of the
> equation (RSC_DRV_CMD_OFFSET * n). But if we had a write_tcs_reg(drv,
> reg, m, data) and a write_tcs_cmd(drv, reg, m, n, data) then it would be
> clearer.
>=20
> Even better, add a void *base to a 'struct tcs' and then pass that
> struct to the tcs_read/write APIs and then have that pull out a
> tcs->base + reg or tcs->base + reg + RSC_DRV_CMD_OFFSET * index.
>=20

[1] https://lore.kernel.org/linux-arm-msm/152364140661.51482.26149034761140=
7195@swboyd.mtv.corp.google.com/

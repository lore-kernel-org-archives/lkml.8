Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA99DC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7B42468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814680;
	bh=mvq7N1igLw7UjhW1AMRRMOdKAT+CXrmcj/HKzuI4XsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=POACT1Ij3U3/RGzWtrP/COu3eahJfM3n9JODWglFKrQH+Otx0zPgt82sYAsXzAZSn
	 YPzm4iLrnWuFXXYXgLcuQ2rA7Eb7iDmp3KvIzisN5LuaYLTpNK2FMR670NaY3XnP0m
	 cbK+PgzvgJGBgvuKo0/HJqBgz9EQrMK0c0MQeHlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgB0Ooj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730802AbgB0Ooh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:44:37 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73ECD24699;
        Thu, 27 Feb 2020 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814676;
        bh=mvq7N1igLw7UjhW1AMRRMOdKAT+CXrmcj/HKzuI4XsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oAmqEnyB6SuIRPZRGXE9vxc3k2lIeDNFueCvEk0PdSrEvUWRP0uirX3R99g8P7uQa
         i/DYIdQ7fznjx8Ch29afbbjEPz9F/bborGbhDKxTWeDjvWJ9yjULt8PuTB0XTBvkYM
         iaUgfZyTNTDkgvuu/Z1pLptq6fVGj2mwKUuojqaY=
Received: by mail-qk1-f171.google.com with SMTP id e16so3324520qkl.6;
        Thu, 27 Feb 2020 06:44:36 -0800 (PST)
X-Gm-Message-State: APjAAAUUbzZsGfSA2m3RW8JzeHcFexedYH1o5TMRpsg7sU7t8pgIh5ev
        2C2WdEdDjFb4JRpHKCtBGKQqZtMJnC8mRa9pgQ==
X-Google-Smtp-Source: APXvYqyY/FhutGJvucWc7ejVRBFSVeez5Yc0iP8BZeLMcHqPqR7EsY5664LyS1HcjV7Xoy8VBy9CBzBssUSEmWXcVjg=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr5913674qkg.152.1582814675567;
 Thu, 27 Feb 2020 06:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-13-andre.przywara@arm.com> <20200226215732.GA32486@bogus>
 <557906ef-28e8-bdf0-5ec9-ab859935f752@arm.com>
In-Reply-To: <557906ef-28e8-bdf0-5ec9-ab859935f752@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Feb 2020 08:44:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLw2eru3k+=LB9Q_MGHTapRy59JgPZTixywzj-Zs_xudg@mail.gmail.com>
Message-ID: <CAL_JsqLw2eru3k+=LB9Q_MGHTapRy59JgPZTixywzj-Zs_xudg@mail.gmail.com>
Subject: Re: [PATCH 12/13] dt-bindings: arm: Add Calxeda system registers
 json-schema binding
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>,
        soc@kernel.org, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 6:12 PM Andr=C3=A9 Przywara <andre.przywara@arm.com=
> wrote:
>
> On 26/02/2020 21:57, Rob Herring wrote:
>
> Hi Rob,
>
> thanks for giving it a try!
>
> > On Wed, 26 Feb 2020 18:09:00 +0000, Andre Przywara wrote:
> >> The Calxeda system registers are a collection of MMIO register
> >> controlling several more general aspects of the SoC.
> >> Beside for some power management tasks this node is also somewhat
> >> abused as the container for the clock nodes.
> >>
> >> Add a binding in DT schema format using json-schema.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  .../bindings/arm/calxeda/hb-sregs.yaml        | 47 ++++++++++++++++++=
+
> >>  1 file changed, 47 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-s=
regs.yaml
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > warning: no schema found in file: Documentation/devicetree/bindings/arm=
/calxeda/hb-sregs.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/calxeda/hb-sregs.yaml: ignoring, error in schema: properties: clocks
> > Documentation/devicetree/bindings/display/simple-framebuffer.example.dt=
s:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen nod=
e must be at root node
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ar=
m/calxeda/hb-sregs.yaml: properties:clocks: {'type': 'object'} is not valid=
 under any of the given schemas (Possible causes of the failure):
> >       /builds/robherring/linux-dt-review/Documentation/devicetree/bindi=
ngs/arm/calxeda/hb-sregs.yaml: properties:clocks: 'maxItems' is a required =
property
> >
> > Documentation/devicetree/bindings/Makefile:12: recipe for target 'Docum=
entation/devicetree/bindings/arm/calxeda/hb-sregs.example.dts' failed
> > make[1]: *** [Documentation/devicetree/bindings/arm/calxeda/hb-sregs.ex=
ample.dts] Error 1
> > Makefile:1263: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> >
> > See https://patchwork.ozlabs.org/patch/1245261
> > Please check and re-submit.
>
> Ah, right, I forgot that I actually fixed dt-schema:
>
> It seems like we can cope with "clocks" being just a node name in
> schema/clock/clock.yaml [1], but not in meta-schemas/clocks.yaml [2].
>
> I added a similar anyOf ... to the meta-schemas entry, which seems to
> fix it for me.
>
> Can you confirm that this is a bug in dt-schema and this is the proper
> fix or am I doing something wrong (I have only a smattering in
> dt-schema/json)?

Yeah, that's right. Though ideally we'd avoid names that are used as
both properties and nodes, but this one is kind of widely used.

Can you submit a GH pull req with the fix (use the devicetree-org one,
not my tree).

Rob

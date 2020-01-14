Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AA0C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579010287;
	bh=4dlEZ5O6TRVm5SzbTpgu6LZbOg6cFR0SckRSi4OV/54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lOXsRFhFkhMcGj01+RgD9LPJ9XzwqjD4WgW6DWfdx9ueAVsClnBL530KH13HjiA/W
	 fI3XSSMASmzZqKmIAYZjZdW/QvW59o7swJHWE1T1mSRt9b10W5YM7mVBIbJtgtswMg
	 np7axT3pZM8b80znUdmV7TxE0M2kPqBqkY/6QeDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgANN6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:58:05 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B9A214AF;
        Tue, 14 Jan 2020 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579010284;
        bh=4dlEZ5O6TRVm5SzbTpgu6LZbOg6cFR0SckRSi4OV/54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a6CQDE6Wezc/6DTSxV/pveS7LqpaHtIKkU+/Yedn2RNU6GB51gi0d5eEO+zOzl5rt
         D4RFGpRQeGE4fUKeWiZ4AOGvZ8uTyQy3g3rtaVeiAjBktgSGFLqZt1MqDWNaA7K704
         QIz70Mvb6jFz3fO6dzqO3MOdMw5yoZeMGHBgXnvE=
Received: by mail-qk1-f181.google.com with SMTP id d71so12171076qkc.0;
        Tue, 14 Jan 2020 05:58:04 -0800 (PST)
X-Gm-Message-State: APjAAAXhPLZZVcI+KK4IJZWuFYeblzyD19dueXUjOiyaN3x6kbI5+Lde
        B/8EYqDDxxe+WBg+ws6HXoRscGy4C46IbNfF3A==
X-Google-Smtp-Source: APXvYqxDqKJxTHzTxrkKkapIjfnZCCCiezeAbzCYinEtmifEiYCBaAW1f0BnGQVFtyjpo1uY/Yp9GeMVllEll9d5gZo=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr20045737qkl.119.1579010283333;
 Tue, 14 Jan 2020 05:58:03 -0800 (PST)
MIME-Version: 1.0
References: <1578642914-838-1-git-send-email-Anson.Huang@nxp.com>
 <20200113212735.GA9275@bogus> <DB3PR0402MB391644F6152A726A13B8F628F5340@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391644F6152A726A13B8F628F5340@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jan 2020 07:57:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ULw1xpBktnjKu_8eQtLg_s7Fi5Jm1yuT8O+cWo3E=ZQ@mail.gmail.com>
Message-ID: <CAL_Jsq+ULw1xpBktnjKu_8eQtLg_s7Fi5Jm1yuT8O+cWo3E=ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: Convert i.MX8MQ to json-schema
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 7:25 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rob
>
> > Subject: Re: [PATCH 1/3] dt-bindings: clock: Convert i.MX8MQ to json-schema
> >
> > On Fri, Jan 10, 2020 at 03:55:12PM +0800, Anson Huang wrote:
> > > Convert the i.MX8MQ clock binding to DT schema format using
> > > json-schema
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/clock/imx8mq-clock.txt     | 20 ------
> > >  .../devicetree/bindings/clock/imx8mq-clock.yaml    | 72
> > ++++++++++++++++++++++
> > >  2 files changed, 72 insertions(+), 20 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/clock/imx8mq-clock.yaml
> >
> > Fails 'make dt_binding_check':
> >
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names:0: 'ckil' was expected
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names:1: 'osc_25m' was expected
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names:2: 'osc_27m' was expected
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names:3: 'clk_ext1' was expected
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names:4: 'clk_ext2' was expected
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names:5: 'clk_ext3' was expected
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clock-names: ['osc_32k', 'osc_24m', 'clk_ext1',
> > 'clk_ext2', 'clk_ext3', 'clk_ext4'] is too short
> > /builds/robherring/linux-dt-
> > review/Documentation/devicetree/bindings/clock/imx8mn-
> > clock.example.dt.yaml:
> > clock-controller@30380000: clocks: [[1], [2], [3], [4], [5], [6]] is too short
>
> I did NOT see build fail on my side, anything missed in my environment setup? The failure
> log is for i.MX8MN, while this binding doc is i.MX8MQ, is it caused by the incorrect compatible
> string which should be "fsl,imx8mq-ccm", but I made it "fsl,imx8mn-ccm" by mistake?

Notice that the error is in imx8mn-clock.example.dt.yaml, not
imx8mq-clock.example.dt.yaml. So you must have DT_SCHEMA_FILES set and
yes it is due to the compatible being wrong.

>
> anson@anson-OptiPlex-790:~/workspace/stash/linux-next$ ./zeus.sh
> *** Default configuration is based on 'defconfig'
> #
> # No change to .config
> #
>   CHKDT   Documentation/devicetree/bindings/clock/imx8mq-clock.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>   DTC     Documentation/devicetree/bindings/clock/imx8mq-clock.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/clock/imx8mq-clock.example.dt.yaml

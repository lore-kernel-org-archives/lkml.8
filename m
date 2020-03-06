Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB16C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D178E20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583503025;
	bh=Y6OCmSPbA3jD52JAF+3WqvAQi2n/qqzlxvjWBCbtPNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=umsrlstj34GlFaV25wro2ebyKVvmmCOzGNSFWElJvkSQI6I4NTbzTtDKyzpqqdEsD
	 cEogm9QnB1sMgkPDBWUTMiyr6GbuaiMzCt6ReGnvLhMo81iU2NpZp3xPN95k+g74/Q
	 e6fNKmO7V2Yu1sjYz+KiNuiZmU888zZM3X61euxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCFN5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgCFN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:57:04 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68E120848;
        Fri,  6 Mar 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583503023;
        bh=Y6OCmSPbA3jD52JAF+3WqvAQi2n/qqzlxvjWBCbtPNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RCwFyKtLLVfrc7ymRU4nisTJcyXBwGlM7KTbIeYIW7QHK78RO7eWYhlKEcrKspb+D
         zIU/t/o7tucig6QnSOS1gAWU1haVn6DYe4v+aaJDfnrShlWLM8yyfTvFZCYTKGJvN5
         3tGejaYsAEgve1HcnDPgAe1LkUimZapdhW6bw27A=
Received: by mail-qk1-f175.google.com with SMTP id e16so2327578qkl.6;
        Fri, 06 Mar 2020 05:57:03 -0800 (PST)
X-Gm-Message-State: ANhLgQ2XkHUI/s/kY5DcoG9Or8DhzqE5vPbFHzK12uamBDOUFQVA2pmW
        9AVgJpuW7oPnitawuz0BMAq+CLl7AqOiV1HL/w==
X-Google-Smtp-Source: ADFU+vtsSDRikZpWPwBiQSZP0IHFW9C5JQmmRvCJ+DsH8dgxQVxMDbmTildHObv/rXXT7ImeYIPAFCIfIDj/lIR+Rj8=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr3090956qkg.152.1583503022804;
 Fri, 06 Mar 2020 05:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru> <20200306124823.38C2A80307C4@mail.baikalelectronics.ru>
In-Reply-To: <20200306124823.38C2A80307C4@mail.baikalelectronics.ru>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 6 Mar 2020 07:56:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSC818+vxgn7Yk0XOAk=NC057VGsFCBt-H65DDkc1W6w@mail.gmail.com>
Message-ID: <CAL_JsqLSC818+vxgn7Yk0XOAk=NC057VGsFCBt-H65DDkc1W6w@mail.gmail.com>
Subject: Re: [PATCH 01/22] dt-bindings: Permit platform devices in the
 trivial-devices bindings
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 6:48 AM <Sergey.Semin@baikalelectronics.ru> wrote:
>
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>
> Indeed there are a log of trivial devices amongst platform controllers,
> IP-blocks, etc. If they satisfy the trivial devices bindings requirements
> like consisting of a compatible field, an address and possibly an interrupt
> line why not having them in the generic trivial-devices bindings file?

NAK.

Do you have some documentation on what a platform bus is? Last I
checked, that's a Linux thing.

If anything, we'd move toward getting rid of trivial-devices.yaml. For
example, I'd like to start defining the node name which wouldn't work
for trivial-devices.yaml unless we split by class.

Rob

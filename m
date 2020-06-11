Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1275CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AFD207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591894579;
	bh=TE418sB8Y8et8fQqJeRiuB08BfOdKipjyUXleiQngaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MHTTXLsDyuFDKqTQRwtXoXvv6MBOjQ+BfrAwEUAd96Vy9xt6IzkQpOGmd2b01wfUA
	 /8xLaQTt42rytJiZfgTGEil3bSiti7aHvqraXgef/4h4tRYnxyji6PINGlDhgINymp
	 4Sv/bhhKSVDDwvsoOYDu1jbsktlbbMbG/6DGzxeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgFKQ4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:56:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40922 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:56:17 -0400
Received: by mail-il1-f193.google.com with SMTP id t8so6079812ilm.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWbECKAlHMMk14Dear354OHlygSb2J3osFMxc7H4JbQ=;
        b=q8igub9ORfhtBamS7DvqkGAAWaRyztAYX8L1NE1Q1OzauvAE0UTznFKIuU3X2TvJ9P
         i2MOIRqfa6HQNoWR26l8SRyZRZ6FFJ5CEO1MupfE0fUqdK+AmMdh/kqDvToSq0YQ5Ykb
         9H0iadPQWPlQX86LCDMSaJalLlBsahE+VfYrvfFLhVMTb4iyBRtdVTO7EBdCeN4dYNP+
         xmLi0xj9F+8HptkfX50cay0hKSSqDQVn7p3GJ6sLDVCoYATpr4TU+hWJJ323qEGyOydx
         0Q2HHV+a+vWL3BBUPx0st5Z+3OHk+lBdQh5qhkbrt+gH1dgj7LJa/xtN21o0lCbHGBfT
         mJqA==
X-Gm-Message-State: AOAM532YFLAiik0Pvy0+24rpqorVgbv4dqEA2q6Ixq/UCgjrDkaBYuS+
        Ucq/yjSboMcGLAogMw3ACSx1AKM=
X-Google-Smtp-Source: ABdhPJyGgSYN2ZnZzRTdtQTWnbN8lGZ32fmmu0RjOoxO+lL2vx3+ihSjt3DtsRPpuJ2mSdWbVIlv3g==
X-Received: by 2002:a92:6b05:: with SMTP id g5mr8622812ilc.120.1591894575334;
        Thu, 11 Jun 2020 09:56:15 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o12sm1687739iob.6.2020.06.11.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 09:56:14 -0700 (PDT)
Received: (nullmailer pid 1230958 invoked by uid 1000);
        Thu, 11 Jun 2020 16:56:12 -0000
Date:   Thu, 11 Jun 2020 10:56:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] Mailbox changes for v5.8
Message-ID: <20200611165612.GA1225679@bogus>
References: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:10:56PM -0500, Jassi Brar wrote:
> Hi Linus,
> 
> The following changes since commit ffeb595d84811dde16a28b33d8a7cf26d51d51b3:
> 
>   Merge tag 'powerpc-5.7-6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> (2020-05-30 12:28:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.linaro.org/landing-teams/working/fujitsu/integration.git
> tags/mailbox-v5.8
> 
> for you to fetch changes up to e9f901dc05c09c4f89183cadcb2d93177f3100cb:
> 
>   mailbox: qcom: Add ipq6018 apcs compatible (2020-06-10 22:43:57 -0500)
> 
> ----------------------------------------------------------------
> - qcom :
>      new controller driver for IPCC
>      reorg the of_device data
>      add support for ipq6018 platform
> - spreadtrum:
>      new sprd controller driver
> - imx:
>      implement suspend/resume PM support
> - Misc :
>      make pcc driver struct as static
>      fix return value in imx_mu_scu
>      disable clock before bailout in imx probe
>      remove duplicate error mssg in zynqmp probe
>      fix header size in imx.scu
>      check for null instead of is-err in zynqmp
> 
> ----------------------------------------------------------------
> Anson Huang (3):
>       mailbox: imx: Support runtime PM
>       mailbox: imx: Add runtime PM callback to handle MU clocks
>       mailbox: imx: ONLY IPC MU needs IRQF_NO_SUSPEND flag
> 
> Baolin Wang (2):
>       dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
>       mailbox: sprd: Add Spreadtrum mailbox driver
> 
> Dan Carpenter (1):
>       mailbox: imx: Fix return in imx_mu_scu_xlate()
> 
> Dong Aisheng (1):
>       mailbox: imx: Add context save/restore for suspend/resume
> 
> Fabio Estevam (1):
>       mailbox: imx: Disable the clock on devm_mbox_controller_register() failure
> 
> Jason Yan (1):
>       mailbox: pcc: make pcc_mbox_driver static
> 
> Manivannan Sadhasivam (3):
>       dt-bindings: mailbox: Add devicetree binding for Qcom IPCC
>       mailbox: Add support for Qualcomm IPCC
>       MAINTAINERS: Add entry for Qualcomm IPCC driver
> 
> Markus Elfring (1):
>       mailbox: ZynqMP IPI: Delete an error message in zynqmp_ipi_probe()
> 
> Peng Fan (1):
>       mailbox: imx-mailbox: fix scu msg header size check
> 
> Sivaprakash Murugesan (3):
>       dt-bindings: mailbox: Add YAML schemas for QCOM APCS global block
>       mailbox: qcom: Add clock driver name in apcs mailbox driver data
>       mailbox: qcom: Add ipq6018 apcs compatible

You've dropped the binding change that breaks 'make dt_binding_check' 
from this PR, but do you intend to drop it from linux-next because it's 
still in today's next? 

And really the above commit should not be applied until the binding 
change is, but fine.

Rob

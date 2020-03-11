Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44204 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgCKPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:35:05 -0400
Received: by mail-vk1-f193.google.com with SMTP id s194so642645vkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <1582890639-32072-1-git-send-email-vbadigan@codeaurora.org> <1583503724-13943-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1583503724-13943-1-git-send-email-vbadigan@codeaurora.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Mar 2020 16:34:27 +0100
Message-ID: <CAPDyKFrqijPjUmq9MCNap6WGV-LocB9zJ40v9hLY547QuPdJUg@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Deactivate CQE during SDHC reset
To: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 6 Mar 2020 at 15:09, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Host controllers can reset CQHCI either directly or as a consequence
> of host controller reset. In the later case, driver should deactivate
> CQHCI just before reset to puts the CQHCI driver into a state that is
> consistent with that h/w state.
>
> Changes sicne V2:
>         - Added support cqhci_deactivate()
>         - Use cqhci_deactivate() instead of cqhci_disable().
>         - Deactivate CQCHI just before SDHC reset.
>
> Changes since V1:
>         - Disable CQE only when SDHC undergoes s/w reset for all.
>
> Adrian Hunter (1):
>   mmc: cqhci: Add cqhci_deactivate()
>
> Veerabhadrarao Badiganti (1):
>   mmc: sdhci-msm: Deactivate CQE during SDHC reset
>
>  drivers/mmc/host/cqhci.c     | 6 +++---
>  drivers/mmc/host/cqhci.h     | 6 +++++-
>  drivers/mmc/host/sdhci-msm.c | 9 ++++++++-
>  3 files changed, 16 insertions(+), 5 deletions(-)

Applied for next, thanks!

Kind regards
Uffe


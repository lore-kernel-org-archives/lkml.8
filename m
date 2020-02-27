Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD1C35E1E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295CA2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7ZikkXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgB0Uyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:54:55 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35202 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0Uyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:54:55 -0500
Received: by mail-ua1-f66.google.com with SMTP id y23so187341ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktzdl5eoKPEHfEuFryFzhZR7Y8sf35Stxv0I9TC3om8=;
        b=S7ZikkXjTCFqfTODdrBIRR4bjKV6vzJmi95TuJOiGc6qU7zDytV2WPccOPkdOwJZ/j
         xli5qKpWBUJ5DazclKwIIfQ8qQMD4fHsNAqdGsEEL4fe3MO0gOR/KmwhvFgRCgvvNvHb
         vijRWYbIUdJ6HmZd/RojRMwFkBppkvmsy5rbTLnwbctZAx6wUY1nJDyxeEApFNEB55Xb
         U/d0YaxRhAe8wd8cADEZdNzur4hfxn5jgLkmh8HD1TUN6quVjk+WYUszsrJcPsODuhpU
         y/6+8DOFTaL7D7XPV1o3rvMBHvAFVRiFIRT2SaijXF4iUNgMsMRkGs0kHJjdl+cTFTSs
         f0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktzdl5eoKPEHfEuFryFzhZR7Y8sf35Stxv0I9TC3om8=;
        b=t+NNT/uMyMVcTwa+T7UB3BRrhJ894WODOAPTYFXfFw0toheLoOJh0LemZ8lw9OUF3O
         O/JF94Zhn8p2GUSpVPUEETXBs1HiAjp5Irk0hYmt+TUAmHNMdtV6h3gpdfK5oGW/6Ky1
         03us8K8M4/+i/Eb1WKryJW1rRrrO7xE54we8YUkVO7F55rq+bEmFeGPpg1WtNEw48JST
         IAt/TauTwAARVsc9GhH15X1upOnDE4rR3ErZ+B/47SFRNpOHjbLZvHgrVj3CRf50UPiX
         7qx6E9iRxlzcI6D8hao2PxOX6oIOt8iXqJqp5xt2W1b0rHFNdocspffTyqr+uGSPOnb9
         cnqg==
X-Gm-Message-State: ANhLgQ0i2EkfWsQnfu/NbRfn2rDOHScPS5bwI+87mwOUOD93z0+Yf2Bu
        t8MWNrF7cYqkVaZ+Ju5JKP/meril16ZUv6c5ZXBZbQ==
X-Google-Smtp-Source: ADFU+vt5Eu/0Gf/mJjQWTqW8ukh7kOFSPWFoB1kOcBU0Lbg1MDkcSsM3OxPy3w+OIQUMQkvfoeEVgnNZxUT2k13A3Vg=
X-Received: by 2002:ab0:6605:: with SMTP id r5mr363174uam.0.1582836893873;
 Thu, 27 Feb 2020 12:54:53 -0800 (PST)
MIME-Version: 1.0
References: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org> <1582545470-11530-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1582545470-11530-1-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 27 Feb 2020 12:54:41 -0800
Message-ID: <CAD=FV=WjSC7h0Q1aQpF74KDpgjOPSKrUR5gBo1ZsFn_o4m5TyQ@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: mmc: sdhci-msm: Add CQE reg map
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 24, 2020 at 3:58 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> CQE feature has been enabled on sdhci-msm. Add CQE reg map
> and reg names that need to be supplied for supporting CQE feature.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
> Changes since V2:
>         - Dropped _mem suffix to reg names.
>
> Changes since V1:
>         - Updated description for more clarity & Fixed typos.
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I assume you'll have a follow-up fixing the driver since commit
a4080225f51d ("mmc: cqhci: support for command queue enabled host")
refers to "cqhci_mem".


Also something to keep in mind for future patches (no action needed
for this patch): most maintainers frown on making v2 of a patch
"In-Reply-To" v1 of a patch.  I notice that your v3 was in-reply-to v2
and v2 was in-reply-to v1.  You probably don't want to do this.  One
such reference to people not liking it [1] specifically said "they
should not be replies to old versions of that patch; otherwise the
threading looks really weird and confusing."

[1] https://lore.kernel.org/r/CAJWu+oocs3T8orMNt6AmdVgWONzZg0vD=E8EdvzE9rOi_XatUw@mail.gmail.com


-Doug

Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6853E2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437519AbgAPTOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:14:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32859 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgAPTOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:14:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so20448567otp.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 11:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1ec9yhp1dLONmQKLtmwYwMMUOtHKCG6eqQo9yTWOQE=;
        b=tjR/NKn0q3EA4RnTi7zRPuL2CnnATS9QiR01PM5V7TguFQjl8XMyYYbuiB0h+PaAyL
         2mWFlexZtBGWaRHE1l/eDerYxMnSRZkEVa7mQN303/IsuWBnREPU9VnxvN+2mccyTf+U
         ivR4d/OfGEfI/MGabJdc01KlnApU3VtdNEcNDtrrviJ+voEdpi3Hwy8QpiYnE4h/ySzp
         SUxr5itBgVLxELli6Gf1HHBzlNAT4NyPLxK70kyZUc18XIeSsYbffmk/2jVlvLTeNA9f
         uZwzb36vx/o05XGXLqGklzW4rPZTcWt278uxoIn5T9zZjN8fBMNMgHwa6NW3OIihk827
         SehQ==
X-Gm-Message-State: APjAAAWJRx25CSN1wrq/LOXVPP0qXbnyOGVPbC1VMog+tBEpQUiTuY+p
        Z5TOA7/tFcJHQ2Gw4L15k0ZBecMV
X-Google-Smtp-Source: APXvYqxCVZvS+hcwZyaQ8EN93Shuq119tS13lLpIU10Y6crf5AINrb13+07pnLHE2CL0IuPdgOzuPg==
X-Received: by 2002:a9d:d0b:: with SMTP id 11mr3423196oti.287.1579202059276;
        Thu, 16 Jan 2020 11:14:19 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id p184sm6961975oic.40.2020.01.16.11.14.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 11:14:18 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id d62so19825847oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 11:14:18 -0800 (PST)
X-Received: by 2002:aca:a9c5:: with SMTP id s188mr486067oie.154.1579202058353;
 Thu, 16 Jan 2020 11:14:18 -0800 (PST)
MIME-Version: 1.0
References: <1578608351-23289-1-git-send-email-leoyang.li@nxp.com> <20200116183932.qltqdtreeg4d2zq7@localhost>
In-Reply-To: <20200116183932.qltqdtreeg4d2zq7@localhost>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 16 Jan 2020 13:14:07 -0600
X-Gmail-Original-Message-ID: <CADRPPNQm2ZK+trtKCo2Mjr+ga2vKCR4hWMoFXd3AMMxRQZ_4ZA@mail.gmail.com>
Message-ID: <CADRPPNQm2ZK+trtKCo2Mjr+ga2vKCR4hWMoFXd3AMMxRQZ_4ZA@mail.gmail.com>
Subject: Re: [GIT PULL] soc/fsl drivers changes for next(v5.6)
To:     Olof Johansson <olof@lixom.net>
Cc:     arm@kernel.org, soc@kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:41 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Thu, Jan 09, 2020 at 04:19:11PM -0600, Li Yang wrote:
> > Hi soc maintainers,
> >
> > Please merge the following new changes for soc/fsl drivers.
> >
> > Regards,
> > Leo
> >
> >
> > The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> >
> >   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.6
> >
> > for you to fetch changes up to 6e62bd36e9ad85a22d92b1adce6a0336ea549733:
> >
> >   soc: fsl: qe: remove set but not used variable 'mm_gc' (2020-01-08 16:02:48 -0600)
> >
> > ----------------------------------------------------------------
> > NXP/FSL SoC driver updates for v5.6
> >
> > QUICC Engine drivers
> > - Improve the QE drivers to be compatible with ARM/ARM64/PPC64
> > architectures
> > - Various cleanups to the QE drivers
>
> This branch contains a cross-section of drivers, including those who are
> normally sent to other maintainers/subsystems. I don't see dependencies that
> make them a requirement/easier to merge through the SoC tree at this time --
> for example the ucc_uart driver updates are mostly independent cleanups.
>
> Am I missing some aspect here, or should those just be merged through
> drivers/tty as other driver changes there? At the very least, we expect drivers
> that aren't merged through the normal path to have acks from those maintainers.
>
> Mind following up on that? Thanks!

Hi Olof,

Some of the driver cleanups are dependent to core QE changes.  Some
maybe not but could have contextual dependency with other patches.  I
will be easier to have them all go in from the same place.  We have
collected the ack and confirmation from all the related maintainers.
For the ucc_uart it is not a formal ack.  Quoted the confirmation from
Greg below:

"On Wed, Nov 13, 2019 at 12:24:09PM +0100, Rasmus Villemoes wrote:
> On 13/11/2019 12.19, gregkh@linuxfoundation.org wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     serial: ucc_uart: explicitly include soc/fsl/cpm.h
>
> So, I was planning on having all 47 patches go through Li Yang's tree,
> I think it's easier that way. So if it's not too late, can you drop
> those six "serial: ucc_uart:" (numbered 28/47 through 33/47) patches
> and instead give your ok (not necessarily a formal ack if you don't
> have time to do a review) to Li Yang picking them up?

That's fine, all are now dropped from my tree.  Li Yang, feel free to
take them in your tree if you want to.

greg k-h"

Regards,
Leo

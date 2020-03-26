Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14082073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585231817;
	bh=PeDZLWIRhhe2o42I/gqvyiiMuKNamoLO8nfHcq+EkCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fjyh+0ZEztRy0lWdUy5ODnmCkx45lyoVSkHb5MXU1g5BCywmiWykY9jrLM+cslgFH
	 IdQjoJVuE35wce/SE+RPKzXzf3e9ipCHsw1V4+aShtIEvgGsZSJ4euFIEBRMmNXLF3
	 ak5mivtUoV1iYflL4pYi6AFVkGZayF7Qw1C7EPLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgCZOKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgCZOKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:10:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF95206F8;
        Thu, 26 Mar 2020 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585231815;
        bh=PeDZLWIRhhe2o42I/gqvyiiMuKNamoLO8nfHcq+EkCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+HavB7wzgTYW3kPySjLPPoFLj+9aNlpEq50YxNDKKRzsgG7ARI+2fa1J4sYhcmvd
         BTOyHlkLNotN2GwwHNkryJ4W1nlUR+pAx11lVOgV1quJL231pXotHGVltvYV2fn+QM
         DqMa1ugiLPJgmlRKMJI7hjcDNVP3f/Fapum5Uwqg=
Date:   Thu, 26 Mar 2020 15:10:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Pratik Patel <pratikp@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Williams <michael.williams@arm.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] coresight: do not use the BIT() macro in the UAPI header
Message-ID: <20200326141011.GA1313869@kroah.com>
References: <20200324042213.GA10452@asgard.redhat.com>
 <CANLsYkwVybRG9L6gDJTzZ=eXut66vJYfuEtOfLzaYaVpdybT1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwVybRG9L6gDJTzZ=eXut66vJYfuEtOfLzaYaVpdybT1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:31:15AM -0600, Mathieu Poirier wrote:
> On Mon, 23 Mar 2020 at 22:22, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> >
> > The BIT() macro definition is not available for the UAPI headers
> > (moreover, it can be defined differently in the user space); replace
> > its usage with the _BITUL() macro that is defined in <linux/const.h>.
> >
> > Fixes: 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > ---
> >  include/uapi/linux/coresight-stm.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/coresight-stm.h b/include/uapi/linux/coresight-stm.h
> > index aac550a..8847dbf 100644
> > --- a/include/uapi/linux/coresight-stm.h
> > +++ b/include/uapi/linux/coresight-stm.h
> > @@ -2,8 +2,10 @@
> >  #ifndef __UAPI_CORESIGHT_STM_H_
> >  #define __UAPI_CORESIGHT_STM_H_
> >
> > -#define STM_FLAG_TIMESTAMPED   BIT(3)
> > -#define STM_FLAG_GUARANTEED    BIT(7)
> > +#include <linux/const.h>
> > +
> > +#define STM_FLAG_TIMESTAMPED   _BITUL(3)
> > +#define STM_FLAG_GUARANTEED    _BITUL(7)
> 
> Greg, if you want to pick this up right away:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Otherwise let me know and I'll add it to my next tree.

I'll take it now, thanks.

greg k-h

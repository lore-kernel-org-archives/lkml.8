Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3232FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089A12145D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rADDYge1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGCWyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:54:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD0C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 15:54:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so5191393pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 15:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oTkXaid7GNQFlYsfEdaKgaeUOuBmaSvEjnjEuHkyUUU=;
        b=rADDYge1q8I0zarVOuiCP1n2dmRmYyBGsy/hzGn98BWsvhF+fO8UEnYF/uYevcnz9W
         nhrP4oB+QqHV1nMJQTc1184IqisHW25ctgVTsb+JHzofrZyC11+C15Ll30Ah09WMEYIp
         DwnIhEKb3aCFGX97TKlx3fhoKhL2RFZv3DzxdW4PQX1/PH02RtgRU70uLjhE3H89rPmV
         rvAPF/2FhpR35IR22Pn1jZ8fbAh5HxEvh87QKNbFxY3ZKqZrNVBAIUe+Zl4w2BKU/Yb0
         0DtcJRDKdjITgVWxDxZ1KNglRN59Gs5W+MJ+C2j2LfupwzOq3EFblegWmxzI+QFz0Tvs
         69Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oTkXaid7GNQFlYsfEdaKgaeUOuBmaSvEjnjEuHkyUUU=;
        b=JuNlWjCmUqI7t0b3LM4aRjkQW4FUOzxfVpG1YpNAHwp/EwVkvzST7ap+FazSv3NVlS
         arQxCgqY8QOtln9w/mRwBsibLnPBgT/ChDbKLnjoh7oQD5qCt30HApsggl81UNmvlnmM
         by8U8k6kW5GW9g4Hf52jv9yjMfeVXnBaDL2ujbIs5QoBd4JFSiMT5PFHehUIqgR5Lqy5
         gkimx72IKGCjN60sM1gUVK9BiJRr2C2AryBni+KI7RB5JGjsAwTVRJZE/y0d20vrOEVe
         B6HEO898R1yaz2NHgpOpojSct3EtyTvEyGDL89Y580tZRKkSKR5Iq3qTF7Xfb3wcpuQ4
         zLGw==
X-Gm-Message-State: AOAM5327x95gFtwKjoXTZowRA5ZHoNiixpAle+KcdxqGLO6RS2Ct5aYQ
        HesONVbWxIJT1rJ1T1EEETY=
X-Google-Smtp-Source: ABdhPJzPGC57mpfLFULngr/NnF0Fhw5PfT+pcnDnv2cckFMj9UhDHYp/0lgx64qalRF9BLeG1Dnvhw==
X-Received: by 2002:a65:6447:: with SMTP id s7mr31250183pgv.320.1593816858307;
        Fri, 03 Jul 2020 15:54:18 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v8sm5633794pjf.46.2020.07.03.15.54.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 15:54:17 -0700 (PDT)
Date:   Fri, 3 Jul 2020 15:54:09 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     tiwai@suse.com, festevam@gmail.com, lgirdwood@gmail.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_asrc: Add an option to select internal
 ratio mode
Message-ID: <20200703225408.GA16494@Asurada-Nvidia>
References: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
 <159379581381.55795.16716505708033817338.b4-ty@kernel.org>
 <20200703224656.GA16467@Asurada-Nvidia>
 <20200703225020.GB29047@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703225020.GB29047@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:50:20PM +0100, Mark Brown wrote:
> On Fri, Jul 03, 2020 at 03:46:58PM -0700, Nicolin Chen wrote:
> 
> > > [1/1] ASoC: fsl_asrc: Add an option to select internal ratio mode
> > >       commit: d0250cf4f2abfbea64ed247230f08f5ae23979f0
> 
> > You already applied v3 of this change:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/169976.html
> 
> > And it's already in linux-next also. Not sure what's happening...
> 
> The script can't always tell the difference between versions - it looks
> like it's notified for v2 based on seeing v3 in git.

OK..as long as no revert nor re-applying happens, we can ignore :)

Thanks

Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC132C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2EC21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHlCLlrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgBMJJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:09:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51509 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbgBMJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:09:08 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so2110249pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+D6JV1cGKdVlDtAW+m7jRjQh6N7gL7VdbcJnvt9t2Vg=;
        b=bHlCLlrS71TfSLzfVmpA0yzkxTs2YuDYJEPD8s25OWzmezLOafgM3tsJc/n7yUovdI
         HcHIEw+zTf6C0D51qxi3GhtUx7gm2PbkvjOSv0pBN1GQQxG5vWRlQ+6fDA4iqTjEVdfF
         kImNFq2IflNEoCYxQbndXYjt77SMfQEY9bnICTPnRJ1deOOSBO/aClWRjSzvd7Et+4L5
         ZjZsmD45zmNDa6bV5cimDGNZuEfZ6QFaVqDrzy65iiq+s0ukml9/iowbao5MF8wSYNbK
         Sq2lf+v1AgBxApWzxZuoha+zobEq2NRbwCe4NI+7QvW1BJNX+XKofD9FFKnxz0GEwocp
         ocLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+D6JV1cGKdVlDtAW+m7jRjQh6N7gL7VdbcJnvt9t2Vg=;
        b=kIEIUf+Vkqg888rPqlLWGZvuvRLoJkyEHCDYumTaqJTidkI+Tx/eUlYndAYaenqKuL
         vib8uVLy/3DmvcFyWngSRrFwB5jEdi4THU3VHirROU20fcbiFeVebEyluQlRK6EI3aAo
         rqirAJNREdn7RZZqVFPQDLkF7iHPIbC88KinLRVT2bl99tfWWQYGo5GBPB0+NmsNSdZ/
         xixm2gfanlnsP69D3JBFMpiOioIKUW6R8bEx+tx5ENIEdckQq+H8XK260le8Rfn+r1ii
         Xz07Xm9UImDeZMyPW17feTEv5kdNBP2gWapI/VdlTV17pM3MHC5ZtUvDOAUyjVBdXnj1
         O3Fw==
X-Gm-Message-State: APjAAAVSNkcT1uQPuI8zjMgysT7JpJYZlpc6+6LZ4M0UHnE18DpXoiIV
        b5y90QVmBG9QEqVFBlgAMxIK1+G6
X-Google-Smtp-Source: APXvYqyezzdFgzKfn8Bl3Ua2nR6clYdjxFXaK3uL1C6LAZTAXRpUXudPhF184QZ/xMJDxMYmjgECPA==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr12560217plo.233.1581584948042;
        Thu, 13 Feb 2020 01:09:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id f8sm1929294pjg.28.2020.02.13.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:09:07 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:09:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20200213090905.GB36551@google.com>
References: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
 <20200213055236.GE13208@google.com>
 <20200213083942.6ue3ehaaycourgfi@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213083942.6ue3ehaaycourgfi@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/13 09:39), Petr Mladek wrote:
> > >  	struct console_cmdline *c;
> > >  	int i;
> > > @@ -2131,6 +2131,8 @@ static int __add_preferred_console(char *name, int idx, char *options,
> > >  		if (strcmp(c->name, name) == 0 && c->index == idx) {
> > >  			if (!brl_options)
> > >  				preferred_console = i;
> > > +                       if (user_specified)
> > > +                               c->user_specified = true;
> > >  			return 0;
> > >  		}
> > >  	}

[..]

> > A silly question:
> > 
> > Can the same console first be added by
> > 	console_setup()->__add_preferred_console(true)
> > and then by
> > 	add_preferred_console()->__add_preferred_console(false)
> 
> I guess that this might happen. It should be safe because
> user_specified flag is set only to true when found again,
> see:
> 
>                        if (user_specified)
>                                c->user_specified = true;

Yikes, I didn't see the if-condition. Yes, you are right.

	-ss

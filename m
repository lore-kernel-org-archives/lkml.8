Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE27C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E01A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSTC4G45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgAPJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:48:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38176 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgAPJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:48:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so3043401wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LH+XrqReIfRgU82O3Uxy47xLMM1NN02QbLWpEzJl64k=;
        b=XSTC4G45i2KY2VECMQBVxcynL+G1wTpS1DEjUTU5GdN3XHZoIb8QNu3ctMZl+m3oZq
         KQBa/H6+of6DvCvmHVN08joDcrKj0sjO6B50pUn3ZpfUeCKIiPBNW/oiELwY9WVWChhS
         CkbLZMg2ozn21B4B0mVdf/Q9lM1TFsR6kdxjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LH+XrqReIfRgU82O3Uxy47xLMM1NN02QbLWpEzJl64k=;
        b=VufUSRTY1EhT84xzyoMNSgbgfGvOWwuJ/N86nM79UyXQjN0o2v9lQoyuKuKijaLPxm
         FTp5SNWRlDzSZy+lclFYRd7MSqG2UT8F53I2GESb/qVmfAyrxYSq31+jrqPBdioEzjox
         pMet7GZsEgaeO2p5jeJaKu5di+Ydb3zNHm0Tk1oPfw6TAxU2S2WauvMTOw1gQcYQxTzn
         7IW9vDQEDDuW6HUgk1LisrPTQ0lvtsjVnAZ3vWYl7CfxrT2rkDMqSOjU1JbHYtRSOuzW
         ri/y7XLdLuSsgV2vjY0wMfx+L6Vlio4kt+LbKi+9QGFaSlg+ImYk/i8oKSe59Xd8B/dm
         TIFA==
X-Gm-Message-State: APjAAAU4Z/nTFpHVLL9FD2V664a6ldCG/8y+cfaYsAavP25sePvC5XCY
        Jg7CzFk7LYO1pgH8cYEDSFjAog==
X-Google-Smtp-Source: APXvYqza1vQikaGW57yGEhXWkQtRB3uIQEg4D5GJNhg1DcYuCMqU06L2smeOxp61LJqkGb5TBIN+rQ==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr5350932wmm.1.1579168130015;
        Thu, 16 Jan 2020 01:48:50 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id i16sm4023441wmb.36.2020.01.16.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 01:48:49 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jan 2020 10:48:47 +0100
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200116094847.GB240584@google.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-5-kpsingh@chromium.org>
 <cd1d9d9f-1b68-8d2c-118a-334e4c71eb57@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1d9d9f-1b68-8d2c-118a-334e4c71eb57@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Jan 12:30, Stephen Smalley wrote:
> On 1/15/20 12:13 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > - The list of hooks registered by an LSM is currently immutable as they
> >    are declared with __lsm_ro_after_init and they are attached to a
> >    security_hook_heads struct.
> > - For the BPF LSM we need to de/register the hooks at runtime. Making
> >    the existing security_hook_heads mutable broadens an
> >    attack vector, so a separate security_hook_heads is added for only
> >    those that ~must~ be mutable.
> > - These mutable hooks are run only after all the static hooks have
> >    successfully executed.
> > 
> > This is based on the ideas discussed in:
> > 
> >    https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> [...]
> > diff --git a/security/security.c b/security/security.c
> > index cd2d18d2d279..4a2eb4c089b2 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -652,20 +653,21 @@ static void __init lsm_early_task(struct task_struct *task)
> >   								\
> >   		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> >   			P->hook.FUNC(__VA_ARGS__);		\
> > +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
> >   	} while (0)
> > -#define call_int_hook(FUNC, IRC, ...) ({			\
> > -	int RC = IRC;						\
> > -	do {							\
> > -		struct security_hook_list *P;			\
> > -								\
> > +#define call_int_hook(FUNC, IRC, ...) ({				\
> > +	int RC = IRC;							\
> > +	do {								\
> > +		struct security_hook_list *P;				\
> >   		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> > -			RC = P->hook.FUNC(__VA_ARGS__);		\
> > -			if (RC != 0)				\
> > -				break;				\
> > -		}						\
> > -	} while (0);						\
> > -	RC;							\
> > +			RC = P->hook.FUNC(__VA_ARGS__);			\
> > +			if (RC != 0)					\
> > +				break;					\
> > +		}							\
> > +		RC = CALL_BPF_LSM_INT_HOOKS(RC, FUNC, __VA_ARGS__);	\
> 
> Let's not clobber the return code from the other LSMs with the bpf one.

Good catch and thanks for pointing it out. Should be fixed in v3.

- KP


> 
> > +	} while (0);							\
> > +	RC;								\
> >   })
> >   /* Security operations */
> > 
> 

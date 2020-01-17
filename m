Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052EC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2397720748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BSQILfuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgAQVPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:15:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37441 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:15:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so10353443plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hDjGeeleL+HbTBakSqxyCbAUHlP2+qcu6KumLAPqXUU=;
        b=BSQILfuBRSQobvuJiAwCAtFsCtM5EZ3Yjz+WXkxV3tDNF5BEcRY5ml8/FNx+XC8r/U
         6vyAvm4ctOfcS7xDBhoVpynWvqR8/3HjleemRToNRjKjCR6ms8QKn+6An++QgXP1j8uX
         in1mTw1za0l9RIg4JeYi2tH7UWttIWEWUb1og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDjGeeleL+HbTBakSqxyCbAUHlP2+qcu6KumLAPqXUU=;
        b=L3PsN9vnDKmQb/3RoMFm4pXZE4o1T0cPESULPc/8f2TRuBSrVYte/5gNBgKCAnA5TV
         0mjrmEOmeEE7cMIf5knrGg5VU41WRWrcf8QZfhSg+yIPn3d47k+FMXIfucl3Iz5LQRsu
         M33JqGEQMscluc9jlybZM/x3Sh5ebDp6oU52Jhny/jPndTqJuQfiZfgdq0811/6dycU6
         PQAWp1PrOYXZdES+iGZBLorwgkUyTEb4blnfR/co75k41o0hSqUE11Xh0U/ZzXSVGIje
         gIR4hRqgyuLpoO10xX4Dk6nRxqAeMwRPPG9H/EkBtp7DkpkY67n5IvAfnGqZDyq7ehAv
         NUEA==
X-Gm-Message-State: APjAAAU4NmbFN6bjPnvsrweeyZyfAf9uKzGfo+qu9EfTZ4BibdJm0eLD
        wcWrpimLDXziomCi2dJoD5WIKw==
X-Google-Smtp-Source: APXvYqxj2qC2Kag4Dy81hHsTvTzPaCLiACq64wPFUzQ1WtYhCxyGXVujZhSdp9ocQqLQzPqwwuoxLg==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr8049276pjt.67.1579295706568;
        Fri, 17 Jan 2020 13:15:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23sm32043042pfg.82.2020.01.17.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:15:05 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:15:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v3] ptrace: reintroduce usage of subjective credentials
 in ptrace_has_cap()
Message-ID: <202001171310.A74535C0@keescook>
References: <20200117105717.29803-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117105717.29803-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:57:18AM +0100, Christian Brauner wrote:
> -static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
> +static int ptrace_has_cap(const struct cred *cred, struct user_namespace *ns,
> +			  unsigned int mode)
>  {
> -	if (mode & PTRACE_MODE_NOAUDIT)
> -		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
> -	else
> -		return has_ns_capability(current, ns, CAP_SYS_PTRACE);
> +	return security_capable(cred, ns, CAP_SYS_PTRACE,
> +				(mode & PTRACE_MODE_NOAUDIT) ? CAP_OPT_NOAUDIT :
> +							       CAP_OPT_NONE);
>  }

Eek, no. I think this inverts the check.

Before:
bool has_ns_capability(struct task_struct *t,
                       struct user_namespace *ns, int cap)
{
	...
        ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE);
	...
        return (ret == 0);
}

static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
{
	...
                return has_ns_capability(current, ns, CAP_SYS_PTRACE);
}

After:
static int ptrace_has_cap(const struct cred *cred, struct user_namespace *ns,
                       unsigned int mode)
{
	return security_capable(cred, ns, CAP_SYS_PTRACE,
				(mode & PTRACE_MODE_NOAUDIT) ? CAP_OPT_NOAUDIT :
							       CAP_OPT_NONE);
}

Note lack of "== 0" on the security_capable() return value, but it's
needed. To avoid confusion, I think ptrace_has_cap() should likely
return bool too.

-Kees

-- 
Kees Cook

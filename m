Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ED32065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6yt5mow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFEV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:26:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D5C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:26:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so4182444pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VeRb96m3xb6MVLzkZ/9bi8Q4G4C90sZuPgPUM9psnlg=;
        b=g6yt5mowRomsCxHiTj+rCKQTPIaAlRT3+6FakMUq17fUAUSWHCWdqhopSjjJkFIDA5
         dfGjWJilOucVdz4mqVU7cY+rQEki0+UNYc/UVTAG3xfptu0L1WsBJMzErpMNcjTeoyGy
         ZG4IzyxBW7zpLK2FoAUiqwNhUmpEqqjumjDtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VeRb96m3xb6MVLzkZ/9bi8Q4G4C90sZuPgPUM9psnlg=;
        b=YmnmKSswxi27sJHf42vQuwL0OHJyA9n1GnUPnMzaccE6yEezcxBXp3ercWGtrDcKXI
         beymdZsm1j7tO8OBJiy4dbfdLFYLW037bqW/zoxoDQG6Lw+XB0/3dMYELs1X6kvSi7/m
         HPnOq0uuCp/k22sFjvu+Yjq9PatQPpj+2riWxNc3wnKbLls+u+Hh4C0y43M95tupvG+F
         PFM46YXIcHY+n5avshYDR1/1gO9bMk7wOM4wHHIWVSPMfGQoO+u2mmd8Eu0VbZtM87xR
         35OvBeR6Nq15l/oSC5QxPw2WNBPGxg8HoBIEx0b8HqVyNK1A/TMSR6PFfuTqUd8auEcm
         9UIA==
X-Gm-Message-State: AOAM530x/0eZkcHMqaljUFBnVPoz39XrwLwr/lyK8/RTSuHIOZnhkBME
        iuC0dNKmDGLpFe0GnEuJPVn2bw==
X-Google-Smtp-Source: ABdhPJw0V3kMeUm0jvO13avWqD+DqRkUeahiiWaS1x3LL2XqbIN2sZ84eMR0ycj8tzYPERJRxmEJ8g==
X-Received: by 2002:a17:90a:ac0f:: with SMTP id o15mr5167862pjq.105.1591392398559;
        Fri, 05 Jun 2020 14:26:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o18sm528652pfu.138.2020.06.05.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:26:37 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:26:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, pmladek@suse.com,
        ebiederm@xmission.com, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: dump kmessage before machine_kexec
Message-ID: <202006051426.4F06C696@keescook>
References: <20200605194642.62278-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605194642.62278-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 03:46:42PM -0400, Pavel Tatashin wrote:
> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
> 
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
> 
> Here is example of dmesg data collected after kexec:
> 
> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

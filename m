Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1EC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E11F206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hpYudzwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGXRzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGXRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:55:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:55:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so4913908plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QrjebX+2MVOIfEwIWOQEBEmYNWrE9lHIByJGfCaahp0=;
        b=hpYudzwzACcZEpNTXqhIf8svOe4F5gdhGn3v/8i/VFeHAJKdvEe7O8ZFIQ/2xPOfM5
         eUZZk0JqNgrmR8+mnIW+v60vhGaERWbXIJj0woZtDy5keFrTIVcMoqzC0Bq/uE4CvYE3
         +ouQm9QjiTT6IYzRowgORlrhQ4w5uXgmCxi4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QrjebX+2MVOIfEwIWOQEBEmYNWrE9lHIByJGfCaahp0=;
        b=fjkzngNllfER+KLc05CTKwS51wU9YV26O20iDIQU30ePvLQs63RiEFknbFpS6w8cc0
         jvZG3RptiioCQekBbxtivZ7wanLuihQ82fBQw1bBqatRnmtwM8t2AzKQI4MTvAIsi5iv
         yn5AUf1O/37i7GitzLIRV4Zta2Nw0UoG4q2Ghp4pdvgBRW7uMOiGqu9OyBnULYbIrU51
         pU6cqeDurglD3pqT0xenOLB/HuazdZYblB3E13u9Xbet70dmYkcHVUJnoeHGFp3txzKO
         v/VhZFJ7fLB/DmidVV+kn0vnTDqbYKoF0AcMMolPdmBz/642WDAuPHJWQ9tUlZdF902t
         BTvQ==
X-Gm-Message-State: AOAM53128o3AQQ4AlgOs3Vku17kde3LxdZAjS9FdvyCtwum846n4MB6q
        RGIbnEqTscsJh/5curI3hYM87k3mhCQ=
X-Google-Smtp-Source: ABdhPJw33GS/18bzdmYBhAOo0OUTefZ+sCJH0t7Z7U3EzxF0uRV20RMB2IXpc67zADTPhpGVqdwIsQ==
X-Received: by 2002:a17:902:e901:: with SMTP id k1mr9615159pld.130.1595613354599;
        Fri, 24 Jul 2020 10:55:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm6805590pgq.66.2020.07.24.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:55:53 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:55:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Martin Radev <martin.b.radev@gmail.com>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 75/75] x86/sev-es: Check required CPU features for
 SEV-ES
Message-ID: <202007241055.655EFCB4@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-76-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-76-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:03:36PM +0200, Joerg Roedel wrote:
> From: Martin Radev <martin.b.radev@gmail.com>
> 
> Make sure the machine supports RDRAND, otherwise there is no trusted
> source of of randomness in the system.
> 
> To also check this in the pre-decompression stage, make has_cpuflag
> not depend on CONFIG_RANDOMIZE_BASE anymore.
> 
> Signed-off-by: Martin Radev <martin.b.radev@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

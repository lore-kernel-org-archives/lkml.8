Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F73C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F84C2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRogBaF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAVSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:51:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44313 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVSvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:51:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so369994lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ioinkAh+8hdBjKUdjvbPg5cD8nQTjz9Mvaag/O1Zfys=;
        b=vRogBaF9UTfXPjeHyGqb2gtDG1LjoYaZY5MYvVinMWT4Enta6ifi55KXyBM1f6wf+K
         hzUbXdLlAXo4+fD8QBq/QXemZ/JMV+HViaZXHtn+13vZrghRsZzK4yNrpoHc6xO9h5yo
         ly+JmalLEu2N71ldvZ9hR1NcG2U7LDTsO+qN9jNpjpMbSgn5dW7zhIc23MaJVAb0K/fn
         1BJ8hkPDxblsltfCmuKQ8FXh7QlDIYNr1xzl1dSGAFLqRa4J4Z4aouyBmty/CDedTzJW
         F/V9BrBA2iiLpAxPywlG7hH09R7IkULMx8DO9C+FISntXZv/tTiHOPN9iPlIxNqE1q0M
         pzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ioinkAh+8hdBjKUdjvbPg5cD8nQTjz9Mvaag/O1Zfys=;
        b=hFdpp/UfFPZvYyqKEZLvKOqHFsNMxhAxM7BVdyh/lOqr9mrT3Skk0KrEsP1zFwR9gY
         vPnxwpFO1VFO6vk0RULUveTZOaXFg3TrhI0hxwUk0xgws32m4aptmVFcKqD4aVDisMkh
         hzczIU4wltyA9vH20MXzQ9pEsSITmBvXFmCRHcc65Q2oIKf2c4es2rNMIViDTtldhtNV
         G+OPEK6luAbxiTvpc5m8lqZbH3Rl+zF74eri3tCoohRi3pItSvwkcIVf9BPGEDYw9x+F
         ibaNDUtp4Z85BdvxZ+GrL+1IuKqDoCGwTT7H+RZ0wrPSIldj1ggT0oIxssIwf6HBfvB1
         laHQ==
X-Gm-Message-State: APjAAAXK+dfi8bdEK3PMORDHgqNIXQvOQJKGAM/NxcvaU137dulqUfB1
        8+sjFHJl2JwjXUcd1xuyq6w=
X-Google-Smtp-Source: APXvYqyp01p4opRWn6sRi832huT3A1VyUSfAOZO3Zo+RzrucpLbJ3i53cF6s9cRvxWwKEfMZxgysKg==
X-Received: by 2002:ac2:5964:: with SMTP id h4mr2505320lfp.213.1579719072960;
        Wed, 22 Jan 2020 10:51:12 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id y194sm8736491lff.94.2020.01.22.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:51:11 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 0CE4246180B; Wed, 22 Jan 2020 21:51:11 +0300 (MSK)
Date:   Wed, 22 Jan 2020 21:51:11 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, alex.shi@linux.alibaba.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bigeasy@linutronix.de,
        pankaj.laxminarayan.bharadiya@intel.com, aubrey.li@linux.intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH] x86/pkeys: add check for pkey "overflow"
Message-ID: <20200122185111.GK2437@uranus>
References: <20200122165346.AD4DA150@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122165346.AD4DA150@viggo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:53:46AM -0800, Dave Hansen wrote:
> 
> Alex Shi reported the pkey macros above arch_set_user_pkey_access()
> to be unused.  They are unused, and even refer to a nonexistent
> CONFIG option.
> 
> @@ -922,6 +920,13 @@ int arch_set_user_pkey_access(struct tas
>  	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>  		return -EINVAL;
>  
> +	/*
> +	 * This code should only be called with valid 'pkey'
> +	 * values originating from in-kernel users.  Complain
> +	 * if a bad value is observed.
> +	 */
> +	WARN_ON_ONCE(pkey >= arch_max_pkey());

Should not we rather abort this operation and exit with EINVAL
or something similar instead of calling wrmsr with overflowed
value? IOW,

	if (pkey >= arch_max_pkey()) {
		WARN_ON_ONCE(1);
		return -EINVAL;
	}

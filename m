Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CAFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943A220714
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="R6Vqu16S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGPAtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPAtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:49:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB908C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 17:49:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so3971801pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 17:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=o2o92rwO9CkuSztudCtshx5MGMYC4PKKPlgn//SYCT0=;
        b=R6Vqu16SO4S7zlcPL9tUftEcCKhhmTuJASV1jHrkm3VX08jfTe7LOeGPzQmLuBXS8K
         bxxMJOyGywyDBigdEoLCLxIncuGOcJ4XQOKkvkC+KbaK6Y+M8e5KJbA10C7AZFsqIfbM
         GsHdaWGDhvvseGp15soN8AXWw1Cr45nqDdgzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=o2o92rwO9CkuSztudCtshx5MGMYC4PKKPlgn//SYCT0=;
        b=RLyf7XE9inAXh1NB4Vzh70ywOlEB/v4Dpnjb5AJmk3zJnWLXskOb3xeBmTzRO//XZW
         TEKsZvnzlEaP2CvxXgTUaEHsUwwhxVbFML9kywGXitOZrNMXprnZbD1zgk7Ih03RsQuo
         kgYAmWomM1sGijzcAAe7rrLOL17INfwJiO6YkadmUltcZPSk4kV2ZqqSw6RcboVZ+kHm
         mwWlayRpBJjLnFT/n3KFyqqgleq0FQ1Mw5QuQ+2D9EyupHntElSuCCxLJL0DZ1/xCVOF
         cnoKx2oUt18CF4F+7ZfoURpX9NymktDQ7KIElTeIuCzI6tcnYvWG8jSarJv0/a7FZAXf
         u59A==
X-Gm-Message-State: AOAM530q5OKMiI4EoJHY+I9O+5Grs/wLgsUDSN4Xb/Ol9tllcT1irkiS
        9zF+yN+NGUJffuDj63evPR1p/0aF4Pc=
X-Google-Smtp-Source: ABdhPJwZ+N82U87oKOvzJ+8+ZKG3CnsD1/N4sgOMAKA9IVhp/S5iMs5muXWDZP36CYKxWy/UtLNkqQ==
X-Received: by 2002:a63:4f05:: with SMTP id d5mr1942789pgb.298.1594860546292;
        Wed, 15 Jul 2020 17:49:06 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-64dc-606d-f98e-b592.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:64dc:606d:f98e:b592])
        by smtp.gmail.com with ESMTPSA id cv7sm3078621pjb.9.2020.07.15.17.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 17:49:05 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
References: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
Date:   Thu, 16 Jul 2020 10:49:02 +1000
Message-ID: <87v9iothc1.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,

Looks good to me.

Sorry for not noticing this before, but I think
> +#include <asm/machdep.h>
is now superfluous (I think it's leftover from the machine_is
version?). Maybe mpe will take pity on you and remove it when he picks
up your patch.

Kind regards,
Daniel

>  
>  static struct device_node *get_ppc_fw_sb_node(void)
>  {
> @@ -23,12 +24,19 @@ bool is_ppc_secureboot_enabled(void)
>  {
>  	struct device_node *node;
>  	bool enabled = false;
> +	u32 secureboot;
>  
>  	node = get_ppc_fw_sb_node();
>  	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
> -
>  	of_node_put(node);
>  
> +	if (enabled)
> +		goto out;
> +
> +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot))
> +		enabled = (secureboot > 1);
> +
> +out:
>  	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
>  
>  	return enabled;
> @@ -38,12 +46,19 @@ bool is_ppc_trustedboot_enabled(void)
>  {
>  	struct device_node *node;
>  	bool enabled = false;
> +	u32 trustedboot;
>  
>  	node = get_ppc_fw_sb_node();
>  	enabled = of_property_read_bool(node, "trusted-enabled");
> -
>  	of_node_put(node);
>  
> +	if (enabled)
> +		goto out;
> +
> +	if (!of_property_read_u32(of_root, "ibm,trusted-boot", &trustedboot))
> +		enabled = (trustedboot > 0);
> +
> +out:
>  	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
>  
>  	return enabled;
> -- 
> 2.26.2

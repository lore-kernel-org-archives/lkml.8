Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C4EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BA820714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ApAQwIT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgC3Sm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:42:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45811 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3Sm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:42:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so20175056qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IFbBMIVJPIzkKV7mLCPNQSK9HoGd/6gdj7ekh+MNpn4=;
        b=ApAQwIT/cpynZQktM+pxIXfok9CoZCSWeCDaFrd/5DNA4ES4emngJj2NrgZRiJ4sWI
         SndJFXnk0wfs4/EBwfsbu25zQnzR98OoXQ9/L63beke3AkYo7R1nJwPmM4KogBPfjCsT
         QYZgDT7950UjIqCK6EttdT+Jc8lL2jxMZa6WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFbBMIVJPIzkKV7mLCPNQSK9HoGd/6gdj7ekh+MNpn4=;
        b=oi/bO41JSgUuL88sGNxCQ/0KJzQXQ1VhWldO0FihE18yoP4J0rDtCh4XND3S5EOROJ
         PPIEh9P06sfpmyrzeffMJncCl0z/w+o+Fv338LBii0cNv7MW0CcaE1Jq10d2sbYGL/+s
         cc3SjL3TLixhwjVxZ8CSqdEg2QSo7MV2sdvzWP+OPI2JixIrXf1Qz+xe04xMliUE5HFe
         GgFpFfQ/seV18n2U8e3GQJZORcQAcuUR2nn2P7NnwnoQ9dJhoybKGDhV7UKg+R+pSiRP
         WBhLY6ipTI4sLMkyYaI1lJRfD9mjBCnCBJP5yEs8G9XBhvXIf2DaM/8nfyQB2Psx2hJL
         sWGg==
X-Gm-Message-State: ANhLgQ0LmJKQO8M4oFOZiUMq7FD7gUgjNOwMMYi0aAsv5vkvYjurHK5p
        6qIV2BbA9mi707ErKaeJiWcPMw==
X-Google-Smtp-Source: ADFU+vs3yNg+YEZEzcjKhOjuZqCRGDXN3aJ+yItda1p7MbfP6hOac0dtsEhPA3FI+8Mj9Xlz53K8Bw==
X-Received: by 2002:a05:620a:22b:: with SMTP id u11mr1404588qkm.225.1585593775508;
        Mon, 30 Mar 2020 11:42:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q75sm10983661qke.12.2020.03.30.11.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:42:55 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:42:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 07/18] rcu/tree: Simplify debug_objects handling
Message-ID: <20200330184254.GA107809@google.com>
References: <20200330023248.164994-8-joel@joelfernandes.org>
 <202003301454.yjTqyud3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003301454.yjTqyud3%lkp@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 03:00:18PM +0800, kbuild test robot wrote:
> Hi "Joel,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on rcu/dev]
> [also build test ERROR on rcu/rcu/next next-20200327]
> [cannot apply to linus/master linux/master v5.6]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

Should have run allmodconfig, this is a slightly older patch and did not see
a problem earlier in prior testing.

Will make the trivial fix now and update my tree, thanks!

 - Joel


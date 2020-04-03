Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6ECC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1297D2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VecubUeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgDCTlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:41:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:41:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so4016680pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nB/KuGxQ1Yug5UW2ITG0E0C4cPdGCwE5JEHZ53qpAgM=;
        b=VecubUeYn09MoGtgixr7S3Himo1g+DnjCmbY1wd8hwF0oiLtpzR0+m8mzO86OMPuwU
         1/deYcagOEViXdSgswNiGWiYNsnD/KGuakkXjjg/111L3rVXD2ICt7/e6+UimpB5O1Ii
         C13Vl4JKOr7b64GuV9Q/S3zDkBYmf4/3/ZSmnx/y7h2dwpfumSA5oJ4KiRHe8xZO41DP
         IVhjm+n+mqMI5k0oq6Z16Q57s3Ls+a57gOu+iMNNQmEPAXCRoehDhBl0InhymmUSeZr9
         JgwLO/+adxsXaZcLhntPdQlcfWtc/Yquxx3n2H785YICRKqEDP6TkdHoNfCHcnwhV9nN
         DHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nB/KuGxQ1Yug5UW2ITG0E0C4cPdGCwE5JEHZ53qpAgM=;
        b=n3zzTFROkYsT05jiRCnKUSUYtu0hIAj7ziS1lh5RZ8UghJ7ZA8Xb3yLkHldOeOGfcb
         ykMbM+UF5R9pN7kLofnStzaCSkPlG5PJhJF2huZ7uN9hfe/PRAM+pHJQYRSxWKfR5ku9
         HmVhTsPNKqhBPnTCDNiKrNHTypfiyAHDA2yHG0ZGd11TZa718RYrE5TGoxP2clts1Bck
         z68D8N9uTAAuP9uth/gxnTa5mJv2sbbHWVVKbEAkwTdLMot/DWpA/GlnqOceFKEjIcuH
         kWHpDvI9BYxTahlcD9L45wtkLtmYpIjcegY9sSxoDDeIJeO8r3t0mQW+8+U9dCogH/7Y
         I5dA==
X-Gm-Message-State: AGi0PuZ+KFrJTsxIDD164BQjlyRdyJMIpDBif1zs8AirbJF3m98aLWo8
        p/KdYKUV/ygFQmVyi6zk2eGoFg==
X-Google-Smtp-Source: APiQypJv/syr4IiHWkl6ahcVcMuAOWYwE+zcjY17t+UbMnVIai7UKwm4o+U3ckJ4+zifH81PgcP8rQ==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr9742160pfb.65.1585942871264;
        Fri, 03 Apr 2020 12:41:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h11sm6420192pfq.56.2020.04.03.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:41:10 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:41:09 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neil Brown <neilb@suse.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
In-Reply-To: <20200403083543.11552-2-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
References: <20200403083543.11552-1-mhocko@kernel.org> <20200403083543.11552-2-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> It seems that the existing documentation is not explicit about the
> expected usage and potential risks enough. While it is calls out
> that users have to free memory when using this flag it is not really
> apparent that users have to careful to not deplete memory reserves
> and that they should implement some sort of throttling wrt. freeing
> process.
> 
> This is partly based on Neil's explanation [1].
> 
> [1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/gfp.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e5b817cb86e7..e3ab1c0d9140 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -110,6 +110,9 @@ struct vm_area_struct;
>   * the caller guarantees the allocation will allow more memory to be freed
>   * very shortly e.g. process exiting or swapping. Users either should
>   * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
> + * Users of this flag have to be extremely careful to not deplete the reserve
> + * completely and implement a throttling mechanism which controls the consumption
> + * of the reserve based on the amount of freed memory.
>   *
>   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.

Hmm, any guidance that we can offer to users of this flag that aren't 
aware of __GFP_MEMALLOC internals?  If I were to read this and not be 
aware of the implementation, I would ask "how do I know when I'm at risk 
of depleting this reserve" especially since the amount of reserve is 
controlled by sysctl.  How do I know when I'm risking a depletion of this 
shared reserve?

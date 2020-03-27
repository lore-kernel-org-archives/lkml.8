Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB19C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5491720774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZORz3IQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgC0MQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:16:28 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33000 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgC0MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:16:27 -0400
Received: by mail-qv1-f66.google.com with SMTP id p19so4730967qve.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S/ta/XSnHTGzReKRmYeOqvL+o0DEdbV+GJUdYHEwsAM=;
        b=ZORz3IQa1vSFeMnbdYj6MSqI9MkOTJC0QA1qNwwPop1+HwvEd7bZ4cOs2Z8aVZXKy0
         F8txb/jEslWWWBSkNVrZM9ovOtEkCIP8yA62Uf6jh/OrVX86ryJvXp4bj12XL2jAkeTm
         SNpVH5pzKTGH7I2ddnJwaxLeKRdqYXorni/5sWOR6A+Bq+xUpH01BvYo5hjz5WniTQbx
         c6p7+FHxJiXDoiSF+qppko6XlaBVziQ8lqoZAM2NcvmZnDj9ckA5OoCu1zI23u86rvIM
         GPmSD0MWABUGFgTS/COIJCt5Xrbwu22/v1WVFmv18apwzN8ma0kBhTaDRrIE60lhuQY8
         5VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/ta/XSnHTGzReKRmYeOqvL+o0DEdbV+GJUdYHEwsAM=;
        b=BSsngBYE7kPBjk2zaaNPLLuROKmpyRL6bEBi/PaQwYW3f7V7UduocXimv1BHkGqvJA
         4FDxNjeF5U9PexRoUsnRMyrVHzTqbXld84nKXutONDXZAuf8F9mphrZS2xwgfyJBReDh
         PMweeY/Y0JugGZuirVR6OHrr7HHru8KgDh6ASm4eb/MxTdde08DGGrckTD8d1JNiISYb
         7nVRgBAAArC0+VC719URTeUBikeVOYdcasZluhoxFzZc16I/Txw1MQ6xNpc1tEeVVtkn
         LvKTS3bbhYxtFyyuvF7WwcUkanUyuzZU9YYlQnixGApWFxbVxkS3N9sXzGq0+2LstR+x
         7PrA==
X-Gm-Message-State: ANhLgQ34d5Y8Kkml7twwWAbWc3hMOlChPcZBL34kmBcJaTwxCcJRsDbn
        waXIKoQUp2CMNzJbenoyk1p5mQ==
X-Google-Smtp-Source: ADFU+vv7TdbZ+yEnsLfOzkI96fzPdYyFM5bhu2lYotTNuOnZpGbEoNwugSKeHBoAdhrhfHq5OXZkSg==
X-Received: by 2002:a05:6214:68f:: with SMTP id r15mr12825495qvz.96.1585311386587;
        Fri, 27 Mar 2020 05:16:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 17sm3500884qkm.105.2020.03.27.05.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 05:16:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHnuT-0007QU-EF; Fri, 27 Mar 2020 09:16:25 -0300
Date:   Fri, 27 Mar 2020 09:16:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 01/10] mmap locking API: initial implementation as
 rwsem wrappers
Message-ID: <20200327121625.GS20941@ziepe.ca>
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-2-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327021058.221911-2-walken@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:10:49PM -0700, Michel Lespinasse wrote:

> +static inline bool mmap_is_locked(struct mm_struct *mm)
> +{
> +	return rwsem_is_locked(&mm->mmap_sem) != 0;
> +}

I didn't notice any callers to this in the series? Can it be deleted?

Jason

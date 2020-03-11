Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A257C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235BC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHdraEU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgCKGSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:18:41 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39956 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKGSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:18:40 -0400
Received: by mail-pj1-f65.google.com with SMTP id gv19so464396pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1lEpduL7xZKe+1xFm5EOElJ3D+S/whf41wP88yrzLmc=;
        b=vHdraEU9oEKRmN/aO1eG26kjWGjH81KxED3NM4nZHoB/x1KrttSyklZ7Gf5jLvxYO9
         0M1Cly43XGEEvR6SB0kuk+vzDhVRnx4YM6aosUcb6dgueW6qDthtW86BNmPFgzGzXV7v
         HdLn6SjhvNJBC8zGztkO4AqiIFy8X/ShovdnTXKEW+m+RhRplbTjCqmnqhp3jf19cil8
         CXQ1bcSEQbdG0qdvlHdl5deAf9cc5YJSbhPSpsdumwE+4KKSLICyKyaeyZhwlDPceaRf
         R/TKunyvDzhfGf9dJ8VQfxJ9m92GP4rEwyfzs7KGLB/xT60TA/DbdLnVxMrVwYS4Go5R
         nv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1lEpduL7xZKe+1xFm5EOElJ3D+S/whf41wP88yrzLmc=;
        b=pWoRaaz1nF5tEfYcaqOEc9yM0Tg9MF28MJWJOzkB2vgfDf74Y3x0LIAOmSHjyIzbDo
         XpdJjZytzGEX4IgbELynsSrHCd5teLQeNuwAWyUUj+XUXaY+8nq6Z2qgmROBwYDoWODU
         8qTZ1vKaFuP+OIp0tLO02v43Bg9NOwvXWo3BhK9+oMxMDMvX8ud/Qdaod8oc0tH8LYFD
         Z0PaHW4SawfjN3ZFz30OGy9KZ9cpqDYs1R0urnz2tOWwvjv7Lgsp0Bd6X9N/WImXziV3
         vO+2W9z1YK/ZksP8H9l34hKRkp/Xr7KNBycQ6JvQigAgj1ha0CsQsZzZkuOOXPyiOYqD
         JtOw==
X-Gm-Message-State: ANhLgQ1zZd58fErkKjkLIfDs9Oc+voHEU0uLXReegNgBabrEYOlvsPvM
        t3HEacTW85Ob6s7kJ1OELhA=
X-Google-Smtp-Source: ADFU+vvS8O47fL1BGe7jlGGM8z07cg2pwVbWu8GfRTzu/U5pydFEmKmrdWddDvTjCX+HUyR8V0pt/A==
X-Received: by 2002:a17:902:d88d:: with SMTP id b13mr1593323plz.228.1583907519508;
        Tue, 10 Mar 2020 23:18:39 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id gx7sm4180800pjb.16.2020.03.10.23.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 23:18:38 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:18:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [RFC PATCH 1/3] proc/meminfo: introduce extra meminfo
Message-ID: <20200311061836.GA83589@google.com>
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
 <CGME20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf@epcas1p1.samsung.com>
 <20200311034441.23243-2-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311034441.23243-2-jaewon31.kim@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/11 12:44), Jaewon Kim wrote:
[..]
> +#define NAME_SIZE      15
> +#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
> +
> +struct extra_meminfo {
> +	struct list_head list;
> +	atomic_long_t *val;
> +	int shift_for_page;
> +	char name[NAME_BUF_SIZE];
> +	char name_pad[NAME_BUF_SIZE];
> +};
> +
> +int register_extra_meminfo(atomic_long_t *val, int shift, const char *name)
> +{
> +	struct extra_meminfo *meminfo, *memtemp;
> +	int len;
> +	int error = 0;
> +
> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
> +	if (!meminfo) {
> +		error = -ENOMEM;
> +		goto out;
> +	}
> +
> +	meminfo->val = val;
> +	meminfo->shift_for_page = shift;
> +	strncpy(meminfo->name, name, NAME_SIZE);
> +	len = strlen(meminfo->name);
> +	meminfo->name[len] = ':';
> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);

What happens if there is no NULL byte among the first NAME_SIZE bytes
of passed `name'?

[..]

> +	spin_lock(&meminfo_lock);

Does this need to be a spinlock?

	-ss

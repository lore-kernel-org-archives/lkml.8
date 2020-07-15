Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8726AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573E420663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594795005;
	bh=72SF09OiKWNVBX6ta9gVBnB9wY+l4ES/Y5ThiS2yDNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pUzaAnH9DBMEq8BMQB+kU2BBAF1Sol6Be0rnKXud348u2U+aT3zJymha1kJSj/7ZW
	 mAVykjipnaa/HQprD/QKHpINwQwHr86jK8x35nYM+00UtW4cs7kxAVXWkMKvgkvNTL
	 jiq2SSm9FBcL9wKZw0zDS70t+1g+hgpD19ytuBoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgGOGgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:36:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54119 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgGOGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:36:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id j18so4154447wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/7YlCQQS4NfdI2cjoTLRwj8KZpvs8wrGSrY0FMkPh0=;
        b=auYB1ZrHE+hLA2QLYSMZCKP28XdnqsbplFy86fYIxJRVCIBanEKafGrrMGjI+iSzyU
         nPKmMReFyEoOIo/IDz3Slmj92b1n4eBTRZukc81zSw8pgOwmfRZbKWkB8blPniiZSksq
         QRwx45UBfyZx/EPQ3mSAadhAUc3MCdeSCzYrYMyjf4gll3aZLgm1PHBrlijoRzwsWd67
         SV9PZjCSN2vVQwx3moQx5P77ZgfkRme8jlA23aM0LWi4ncb1jA6ovxHWOacMzkhEvrbf
         Qkb26bVeeHXWM7tSzrFlLXBCHGnar2bQ034bYsS76Z9c+/oeuoj/7CC1hPHR9r1LmWRC
         Fqug==
X-Gm-Message-State: AOAM533XIZuLu6qAenkeL6OaaxiCM7WSl0E84LsQ/p9l4dH35aigkY6r
        Zp+3Gz/JmH1+S0+Po5E20Og=
X-Google-Smtp-Source: ABdhPJzhsPV6nJJtiemGrmFxaPyOMI93M1GFQlk9i6/jxMDh1l1C4XRZG2kXT5m6ORa3FiYsr6xBRg==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr7024055wmg.116.1594795001964;
        Tue, 14 Jul 2020 23:36:41 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id u16sm1896668wmn.11.2020.07.14.23.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:36:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:36:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Todd Kjos <tkjos@google.com>, Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: possible deadlock in shmem_fallocate (4)
Message-ID: <20200715063639.GA5451@dhcp22.suse.cz>
References: <0000000000000b5f9d059aa2037f@google.com>
 <20200714033252.8748-1-hdanton@sina.com>
 <20200714053205.15240-1-hdanton@sina.com>
 <20200714140859.15156-1-hdanton@sina.com>
 <20200714141815.GP24642@dhcp22.suse.cz>
 <CAHRSSEzbCW3E0QTR0ryf3p=5J5uhs_vY2D6fFQEzP=HeCDkPGQ@mail.gmail.com>
 <CAJuCfpExhJJO_xPk663-eUkmAXVVwNDd9a7ahQuwMW8JVMBJpg@mail.gmail.com>
 <CAJuCfpFz9kEfTPxcausVj63mUvU7i6Dvv6=KNePVX2qR+-Ci2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFz9kEfTPxcausVj63mUvU7i6Dvv6=KNePVX2qR+-Ci2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-07-20 10:32:20, Suren Baghdasaryan wrote:
[...]
> I'm not sure how we can annotate the fact that the inode_lock in
> generic_file_write_iter and in shmem_fallocate always operate on
> different inodes. Ideas?

I believe that the standard way is to use lockdep_set_class on your
backing inode. But asking lockdep experts would be better than relying
on my vague recollection

-- 
Michal Hocko
SUSE Labs

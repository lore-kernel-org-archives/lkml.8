Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D721C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FE42082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579251577;
	bh=v+3ynnBfrjqoGN+Thy355G0bn0oK1WOrvWgsCKxk3S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NhgNe/X71VSRjERoHYacsQ0WfhRwNAUfJ+V9/iQtuvRkp9sRhXeCXYulGEwK9eMhh
	 1VGln2Hyqf3z+GhYEoiTr42g7DGCmymKalM7E4CnYAxaBmrLRoY7N2PcUwZICw+D38
	 1qWzDPpTZVMxBK7q1OHbHM9xjoUV9QvFd2rUOoR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAQI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:59:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39581 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgAQI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:59:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so21847037wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 00:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bU5V3HcfnedIuSE41RRJUJPnV/DJF/R8QkDrgRzYna0=;
        b=cqctvoACrQKgQvrEfXFfHv6PDv3rPEs7Ldt8N+OoP+cj7hraPynbHvhrIOcIUPwgW7
         cTFlqAeHhWWfmeQaBYzHiOUK44Lx+nfsVLKRGx9g5ZvuZqya6FQ5SPHZnV2XQ0ORMTqx
         367/muKvj1C7DDEb7L6g1JX4wAWTFHs6OhlNk+7wOqHJ9Ng8Z2DJyr5l0g8tg92rk37p
         tUSSdSEHbTgsdbFhGXSSIWUwNQfiKpCMBEl248BkCDfqVfwSGiSwvvOuM16LlHJ9P+QO
         EeXnRxiSh3p54RFwBUyEmbF/sOzQHr45cIkFZX/cVTK5YI31soHX22NiBEA8EmzOoPS0
         gkyw==
X-Gm-Message-State: APjAAAX1LvTnwS+75Z1PWXZNYk0xdhzL0NPib2N/6D9VLg9PwdqtLFiK
        1DpR8Ncb/joHmGvZ3D3KR2g=
X-Google-Smtp-Source: APXvYqxtNWnpac+vRyvGriuN29/Et83dmU7tb+FO6rKdkdkIBjo+W46IOMGqukuyLbQGv7HpUwxI5Q==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr1868575wrp.17.1579251573800;
        Fri, 17 Jan 2020 00:59:33 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id r62sm9737457wma.32.2020.01.17.00.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 00:59:33 -0800 (PST)
Date:   Fri, 17 Jan 2020 09:59:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117085932.GK19428@dhcp22.suse.cz>
References: <20200117022111.18807-1-cai@lca.pw>
 <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 09:51:05, David Hildenbrand wrote:
> On 17.01.20 03:21, Qian Cai wrote:
[...]
> > Even though has_unmovable_pages doesn't hold any reference to the
> > returned page this should be reasonably safe for the purpose of
> > reporting the page (dump_page) because it cannot be hotremoved. The
> 
> This is only true in the context of memory unplug, but not in the
> context of is_mem_section_removable()-> is_pageblock_removable_nolock().

Well, the above should hold for that path as well AFAICS. If the page is
unmovable then a racing hotplug cannot remove it, right? Or do you
consider a temporary unmovability to be a problem?
-- 
Michal Hocko
SUSE Labs

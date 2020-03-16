Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A7C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F21720679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDUrqXNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgCPWQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:16:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:16:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so23243676wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ipMDfBVAMyLNbQEs0O89B52Q8CgpEgd0HJoy940o84=;
        b=rDUrqXNfQ6QAZRw1ebLOjgAmUY+zdBr/wr00Tn9UVbDVWZh0L3BrZgTtDRjyi3HpnV
         POReGPeXPkc0ibX6k9TNC99d7hLNevV8kBX3o0kQqjPglLW8YRDHmS3CQNkWnXj8BK1k
         b2M0iILM5iMMngmdVKiQ4ywPpuqNotHwmYagYaLWtY+B/5KVpUQgUceqxLv9NcTuNNx0
         G7EY6IUycmSs0BMXvF/XtA4LLeczibS6ptxcBaEo/TqMF93bUyME3wkgt7G65nO8MWRV
         tqxYhIIZeypq9I5cwvRqkhnwzXu7cvBTvhHSiCcGFK3964eWIlpdvdeJf87DjXITVV6f
         Rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ipMDfBVAMyLNbQEs0O89B52Q8CgpEgd0HJoy940o84=;
        b=kofL+ZqqR+iGq1e8bA9k9kMvGny2i74MSR31GvGHjhbq/gazDM/EZYH5oKvysSifBf
         GziGqcJLCtWMyGEnUGXoihgAiUfAUL5MqGvEAannFIqxwmFYPsvXA/sb7D7YZfO40BBz
         plo/Fev49lKs3Guj4DJ2J4GgOhgMeyeYD1142qPAWihNqnVURb9BSHXicqmRj1jm0205
         VElplfWYgaMcAm9manMALsXoOBOdn5nqiqq7D8hYAplbIYc6Ly095nlGVUbpHLrOCMsD
         r0US3q45HxhIs4xrMx9zUQkJNbMyupap4NZ7Xkd9O6rARCnjvM+WEtP9IZkYaDAkuoYQ
         gu1A==
X-Gm-Message-State: ANhLgQ2J1vVDgxHvFVimspaVJvGx0leTp506W4f9XPKjMF1V0mqAUPDM
        Uz12wZIRBm1MmzvOgrUcLcU=
X-Google-Smtp-Source: ADFU+vuFbwnhRFo5Dda/vLml2HSpZlyhdRruCctRD8yqem72BZLQBJ7jeAyH/wR91BpnxK/5cGgFdA==
X-Received: by 2002:adf:b197:: with SMTP id q23mr1548867wra.412.1584396988286;
        Mon, 16 Mar 2020 15:16:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k5sm1250889wmj.18.2020.03.16.15.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 15:16:27 -0700 (PDT)
Date:   Mon, 16 Mar 2020 22:16:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
        richard.weiyang@gmail.com, vbabka@suse.cz
Subject: Re: [PATCH v5 1/2] mm/sparse.c: Use kvmalloc/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200316221626.lyepjuubytto32vz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200316102150.16487-1-bhe@redhat.com>
 <20200316125450.GG3486@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316125450.GG3486@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 08:54:50PM +0800, Baoquan He wrote:
>This change makes populate_section_memmap()/depopulate_section_memmap
>much simpler.
>
>Suggested-by: Michal Hocko <mhocko@kernel.org>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>Acked-by: Michal Hocko <mhocko@suse.com>
>Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

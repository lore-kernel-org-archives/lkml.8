Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07192C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D045E2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579681013;
	bh=IQ/FEHSUYTq4MF7zIjaD7NSfyIxRdAWIX1zopUqdgeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JB7OfdI7NMt6OXwfGpaV+Xw9pvhzLP0aw+zAjvUZ2dNUNLZuBstQpilJodSZTU08/
	 oHunfvEo1caA3u/4o0iYFvJbgYOxldCpyfGKDlr+36Xi+cDJNORXyxr0+CXcfO9wps
	 +UKhSTvup2yFRpZJpQ48rUBUH8I+6r5Acs4WY3fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAVIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:16:52 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51758 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgAVIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:16:52 -0500
Received: by mail-wm1-f45.google.com with SMTP id t23so2170607wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 00:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LoRSqKk1Y9fzNDM0PWuPXgFa7jvF8crByudPZF5LPcg=;
        b=I/h7KFOW3Z763VCdzebj9dpyE1BGuNxPvR18Auusn29YYMv35/C60vRpcBpfq8jlGd
         Wl9I/diMpNKyjFGvUkBlr/gnzenxShJ1N+jkNXxj6AQWGBE3SHjcLcVl7xu/UMXBiPU4
         3PcDqvYiZJAIKWawtLVWOuh9f6wzWF3ybMDTZTNVZTY/EeCAlDA3xgICQzhzgCZt2V6e
         kKVZcc4iQIvPID0PcBZbSP/YdOgZw7zlHJJCD9o/2rqR8Q7p7UZV0LzVAP8FSHHtYGLu
         LbujG9SKw6MQWPW0jZWnQgy8OOOW/5tDmwogpa5ipAv73DfB6fAImXKezAZVOIOI4At7
         OrPA==
X-Gm-Message-State: APjAAAXyyCT37MbEZ5IIxNQ+AHW3MvmfoaMDFN9iY1p/5/HBfDG4Y0ZC
        eB1yCe9O/1wRfNEHgijxkVvtdwr8
X-Google-Smtp-Source: APXvYqwRp0vBN3qp2dBIZqKz8FfOj95fi1n++65WtZBmyyGS47oFK/BBNsXbJ2xxC0pil1QPQjKQvA==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr1522990wml.115.1579681010553;
        Wed, 22 Jan 2020 00:16:50 -0800 (PST)
Received: from localhost (ip-37-188-245-167.eurotel.cz. [37.188.245.167])
        by smtp.gmail.com with ESMTPSA id f12sm2813127wmf.28.2020.01.22.00.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 00:16:49 -0800 (PST)
Date:   Wed, 22 Jan 2020 09:16:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 1/8] mm/migrate.c: skip node check if done in last round
Message-ID: <20200122081648.GP29276@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-2-richardw.yang@linux.intel.com>
 <20200120093646.GL18451@dhcp22.suse.cz>
 <20200120222540.GA32314@richard>
 <20200121084205.GD29276@dhcp22.suse.cz>
 <20200122003650.GA11409@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122003650.GA11409@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 08:36:50, Wei Yang wrote:
[...]
> Well, this is a trivial one. If you don't like it, I would remove this.

Yes, please drop it. Thanks!
-- 
Michal Hocko
SUSE Labs

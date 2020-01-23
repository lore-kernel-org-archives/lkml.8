Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370DC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD80124676
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579744108;
	bh=LQQC18mrodISs+BUMlN5/xE58znheHybN/F31gs6cTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WWoOYLc1h+0131k65UFkfwrDZuhv/9rSz40Ozz323UNvQoI3gcoMyOz83YX4fp35f
	 o8m98K7+HcAofDCy1Q8gTGN6yOHouwhnMKV+kV3awmD6Ith4pAimrNqwUyaU6vcpf/
	 zgh0eV91EqGlfFDHFw293mPOiLTmP+AAwjeqnSMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAWBs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:48:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37260 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 20:48:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so739521pfn.4;
        Wed, 22 Jan 2020 17:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ozr5+gaJdgzJvivhlGq2jJH7zb1U0pgB7yn+lI8/pI4=;
        b=WlW56J71uHVXgrEGViVbGQnKTKpgD/QcrbKnL1khjGeDuiN0um+9Xhaw5KzE3i14Jj
         Y4rCvOiSmR9ez9jPzAq5343xFYL8SdUGFrhM6A6mBj+x29asfFLOTiSJUC7Yvyw6jNJz
         ESYwUte+jXTklXP186uTqdI+BtJJ0MMUQ9QPHFDhn3ZapagpVTW21Q3q5P+Pb60zEsA5
         OIJRM/pvAFwKd3bn87HxgOc2E3SrJPwtTyK+N8N3CfZlakQBRVsGKyYP0GGTo9Aa53yq
         OnIeO5HiJmpxytgX9IKpkxuyiY968WMya0wSQKJAc8w9qZKkYMUIt9qR2E4FaiNNqETU
         a3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ozr5+gaJdgzJvivhlGq2jJH7zb1U0pgB7yn+lI8/pI4=;
        b=HaIWLzoN1JKGg4vc0tpOXq7gd8PsWXwhUh/pzlrwUCs9bHRItXJkzpJSWHiKTLxmc/
         zdXwzc2gJ4jVThHIDl5qcMCT7yV2BMQgB29ruDRiiZmm/c+bBG88RjsdbtnJb3DjEMAa
         CG7E47bhnII4XGb5fnbU1vEEoKNSfLmfNThvl/rbJaCxpSq6vO9oqGbN520quw22uBml
         p0FSVsM7PGCzT056pXWt8i5NRBRMeIFMiFPWJlg23Ft5WZi6r6ujwFKzwmmj8PBTU9Me
         H1AoEu76hFyXrqklPw0CYSXjHWSbspJFu2WjqOQqu+ZEtdshzEAvSm1JELWNYsjtCKZb
         knQA==
X-Gm-Message-State: APjAAAUfZtE3e4Unr821vNvc33ktoRFqU27HEoM+CHUE9eylbWw+8WNi
        lUEvl23RJVjnd1UFBu8QuRzFI2l2
X-Google-Smtp-Source: APXvYqx4MWynQV2OHTUc/FpV57kmeoo0K/vr3b8AJ50YbeLVn/1gnrO4CKHIo63zQ4DT98FAt/A8ng==
X-Received: by 2002:a63:b58:: with SMTP id a24mr1311262pgl.351.1579744107102;
        Wed, 22 Jan 2020 17:48:27 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id i8sm198421pfa.109.2020.01.22.17.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 17:48:26 -0800 (PST)
Date:   Wed, 22 Jan 2020 17:48:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: zram: various fixes in zram.rst
Message-ID: <20200123014824.GC249784@google.com>
References: <77000e12-677a-62f6-9f78-343be5bd6630@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77000e12-677a-62f6-9f78-343be5bd6630@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:51:41PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix various items in zram.rst:
> - typos/spellos
> - punctuation
> - grammar
> - shell syntax
> - indentation
> - sysfs file names
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks for the all corrections, Randy!

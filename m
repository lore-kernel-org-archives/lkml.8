Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA08C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DE921556
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581292827;
	bh=jLycCzI0xf3B5/M7WGHGiCUQ+zIKY3Ji9ADP5oWlp7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mz3+0OZqlQB8nEkB8XFPmniz1Ouyaccew2RriIdDMzfF9W1yEAYualBw1LBFo3PSy
	 94ySYCKiNhpti0NvbGr4ceuriSG/OBKfZHlVR7VayvndPnJ6KQd2BzcQ3v37Snuvlg
	 j/22kIKQqWGTCRSqqbZLI6fGTovHTsdAokXO6NV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBJAA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:00:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38842 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBJAA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 19:00:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so7585481oii.5;
        Sun, 09 Feb 2020 16:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLycCzI0xf3B5/M7WGHGiCUQ+zIKY3Ji9ADP5oWlp7E=;
        b=sCNVjgXvxOf0nIACB5eLk3ZU4yX7MGggr09h1yXGqwKvqkmLTIhP1CzWNY/Zsqb11z
         MQ8uIZKmK5/CeIT0tU0jD/5qPiFdbJ4EA84gwomMaT/XkYrdhSa45Pw+qUSP4146Hxma
         IXSpimMeiJT6JxpbvrHrS0rhj2PNmhmAvzg24ACZL7uYDWz2QlhX3bGSeUIjduxpIFVr
         7pBH4h/kj8Cm80JKq12DD915DyjcnLzuiiKw57vvtUv+eEILTkl3exCdkB1erP9SGiDP
         4jjlqgBPknqGDQgp2vR2KbVfaKCrWZGoetlpQG5j22k7nPdoWMMm3Oq5GpkcaYkd7dDM
         hb0A==
X-Gm-Message-State: APjAAAVql9FKkFq67u1dZ22FsB7wtB/RuhtQ3ePW0bnl16QLlhexkBld
        ZFRN7ZdSjlVyhf/+2FoLSvl+7m1TO5k2pS3B1RaqUA==
X-Google-Smtp-Source: APXvYqwTcscglPwrLHEifESum0llaHuX9ihih4ZqPd2v7rp2Y2irhRKtO7zpme2ydt7rgLx4RtIO6RoKHdsbZGmx/tk=
X-Received: by 2002:a54:488d:: with SMTP id r13mr8774250oic.115.1581292825704;
 Sun, 09 Feb 2020 16:00:25 -0800 (PST)
MIME-Version: 1.0
References: <1581237249-29608-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1581237249-29608-1-git-send-email-peng.fan@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Feb 2020 01:00:09 +0100
Message-ID: <CAJZ5v0iuLwO0udw+FygrgRfHUpVvz9YziPhKpM-WsJtma+BsSQ@mail.gmail.com>
Subject: Re: [PATCH] PM: replace S_IRUGO with octal numbers
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 9:39 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Per commit f90774e1fd27 ("checkpatch: look for symbolic permissions
> and suggest octal instead"),

This applies to new patches.

> octal numbers is preferred, so replace S_IRUGO with octal numbers.

Not really.

Thanks!

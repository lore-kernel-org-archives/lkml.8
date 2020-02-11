Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FCC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212EE24650
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hpCIi6+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgBKSr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:47:57 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46870 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgBKSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:47:57 -0500
Received: by mail-qv1-f65.google.com with SMTP id y2so5470532qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WW6skYTkWTR1YRkvvQUrNrT8hjiq0jQHnJpZVkMjaaQ=;
        b=hpCIi6+1ayP+tW2keaENP2APYj2FgrMZs5NVPprFOi/KWNw3+iHpZznL6c4BKJS922
         QZTVndXoo2l4xwVYHZP/hZjd39pQ88POjJzpBdcJW24MO2ZbCyR+e8+lcyyOoVb/Ja42
         DQ4yp3DT+vmCNBRzO8/kmw99D6rXNF4LITIwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WW6skYTkWTR1YRkvvQUrNrT8hjiq0jQHnJpZVkMjaaQ=;
        b=ScYrWtqvylGBD9P7z7eVQCIRSm7PwRoX+Qyf9CET8EXWy3nepPEnlHidD5djcIuScS
         YHwiR+EWpugO82KiV5fa8TNhvBFW9PTQ7dCwHhrgJHX03hgXhPV41YgbFZgx2bSZhftN
         Rhp5whzwhYkllY6TaHR/Ng6OK0yzp9YEegDrpElqIsFkZbl0P/IedAMxOjMPTuNKDZV1
         tG2n6JnHK/uAS4TQHR3cSXDcC+RSEZguASIuL/efPuwneIe/BrnAWWQbvROeXts0sX9r
         orScGrynpRY4IK984brl5Wt7/K00E++vS0DQ+RwFAsUdQ2lBw/+vzIuM253pvDN0wmgz
         RGWg==
X-Gm-Message-State: APjAAAWs1GzxlmHapLMOtoV6IpqcTbv3F1UVshenvZdBvxY5GyC9r2ex
        tYoxOALcWcmhFNs24vAHDzPrhg==
X-Google-Smtp-Source: APXvYqxuKhGzwecOKVakvuorhqFT/Msgz+GyKOBCyFJL/qjlp+QOBsZ+S9qe87XSTYwmivq7/TLuPw==
X-Received: by 2002:ad4:4a14:: with SMTP id m20mr4226356qvz.100.1581446875885;
        Tue, 11 Feb 2020 10:47:55 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m95sm2586112qte.41.2020.02.11.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:47:55 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:47:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [PATCH 5.5 150/367] tracing: Annotate ftrace_graph_hash pointer
 with __rcu
Message-ID: <20200211184751.GB250925@google.com>
References: <20200210122423.695146547@linuxfoundation.org>
 <20200210122438.674498788@linuxfoundation.org>
 <CAEXW_YSPDHcuLiM4B8uXvw-0ei2Gj0x=QE1h+NMqzRiBph1oNw@mail.gmail.com>
 <20200211012638.GB13097@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211012638.GB13097@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 08:26:38PM -0500, Sasha Levin wrote:
> On Mon, Feb 10, 2020 at 06:36:20AM -0800, Joel Fernandes wrote:
> > On Mon, Feb 10, 2020 at 4:40 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > From: Amol Grover <frextrite@gmail.com>
> > > 
> > > [ Upstream commit 24a9729f831462b1d9d61dc85ecc91c59037243f ]
> > 
> > Amol, can you send a follow-up patch to annotate
> > ftrace_graph_notrace_hash as well?
> 
> Note that I took this to make later stable tagged patch apply cleanly. I
> don't expect these annotation changes to be picked up for stable on
> their own.

Yes, that should be fine.

thanks,

 - Joel


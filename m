Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A1220724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYnHMwYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCMMUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:20:51 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34689 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgCMMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:20:50 -0400
Received: by mail-pg1-f169.google.com with SMTP id t3so4922169pgn.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbs/iiV47rfQlC22F3NJw1KeqJdaSB+dKcS/cxMTah8=;
        b=kYnHMwYJxUH+aLE+Q1eAIgAPP7BZXYhc3sN5bZ3zZjUfiCFl6CwFngoHm6IU0gyqlW
         hXA1qAtN+i8zwQHcX8QaXcIE9lG+auWxOh2zSN1cJq4reQp4mv/ml+7TSeFShC0ntxHz
         xsV+UVOCNZ5fLT5KtFNP0TkwM6Q8o/bbbocbX66iOaVL0ZoswXfdsKrtLw3ss6Db5Zn0
         mZxBIg3+YoJm1Vymh2JYfVWdpZWeakLvOJnNELd3lnNcS8wVCN2ytZmGIPQ5q+7qbr/f
         wvRLFNzcQ9gdo0s9w1trvqL4Y+VR5Fz3V6BUCyYJy8GExSu+C98rZtoyHgcdLrciUkwL
         9X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbs/iiV47rfQlC22F3NJw1KeqJdaSB+dKcS/cxMTah8=;
        b=K5G7w/ZcwIzu3eRLXYMq3HU6xsYESQOKiEolJJXnp43TLxjLqudjEKECToL6/57mKv
         4ff43SXa7YLT/JcqqvqXAsu115X1Kw8Ewv/SiM86PryZy+1bXXkXl11XWopC5EQmWULa
         DLEM9Qh/FYDOmuXBlmy1nQtcF3G7ZYS4PY2d8dux3Vz0jjFUotfLxmr8/jsIRUFnGbEz
         zDauWAVEC8NkDzAg2uq0sVjz5plMomRBXvJK+6kjz2WUjO21L9wRp/Zvnxru4ibzdDlE
         bFcIEUhM2Vv2CVRIGVIiXbvaeaVVR2uerLrNJBck9W8KKXjyLk2U3s4E5SmbxSL0qxNE
         5MFg==
X-Gm-Message-State: ANhLgQ00iw38dkCNZAxLwF3FUBv4b1xSd4Tyun2Wjfu91h5AYonjzekz
        yR9P7f2u04MC528BsUugeD8=
X-Google-Smtp-Source: ADFU+vtmuWjwxs6sGeXAr28yTx70DBYNc3NYVXxwG3G6TUGxUsGWCbqxaAAd54L1sF4lScvU2vvWBA==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr13623071pfl.252.1584102049990;
        Fri, 13 Mar 2020 05:20:49 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id a6sm12138038pfb.104.2020.03.13.05.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:20:49 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:50:47 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Subject: Re: [PATCH v3] c6x: replace setup_irq() by request_irq()
Message-ID: <20200313122047.GA7004@afzalpc>
References: <20200304004143.3960-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304004143.3960-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark Salter,

On Wed, Mar 04, 2020 at 06:11:43AM +0530, afzal mohammed wrote:

> Hi Mark Salter,
> 
> i believe you are the maintainer of c6x, if you are okay w/ this change,
> please consider taking it thr' your tree, else please let me know.

i am seeing the last signoff by you in arch/c6x around 2 years back, so
seems nowadays you are not sending pull request for c6x.

If you are planning to send this patch upstream, let me know or if you
are preferring to ack this so that this can be routed via tglx, please
do so (you had acked v1, since there were minor changes, i removed it
on newer versions).

Regards
afzal

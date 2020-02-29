Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C083C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2035F246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvR+tLYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgB2NP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:15:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38185 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2NP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:15:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id p7so2363782pli.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 05:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+0YRe2gSYzGlvvWEiaZCl0DzmnemeTPdfohOnZ9dWPM=;
        b=uvR+tLYffhQ915XmOOftyjm4OPxXIELK1yqQy2UfLzLJW8036f90OpqOoufclzljwM
         JMyGCCJjKh/qHQ6vB3HniHdY3DCM8tXfD2YLJQXJfW1X3q6kH48chr6scqjenNPMle6D
         JKJ+K3khmS6MwvGSE9t1sBdFMQ3ISzwnqkLovQ8Veal83d6PzQ0yDF7wUXc6WDnekhxh
         K4Z2zP4hwyMNkFGx+iZDoJ6RpMiWkfyXVA3t48ZjSIu++rFAZ45DxO4t4NtrItgQ024M
         U1HV2yy+WPds0X0dJGrLg6goV5NSnG1XQhPflPnYLuOR6LV+IGG659e/7wIRSSc9QRSd
         8MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+0YRe2gSYzGlvvWEiaZCl0DzmnemeTPdfohOnZ9dWPM=;
        b=ptMUrY3ptNtvfuc8RO9akzqRutcRBKVW+pRMWn7Kc48SaUUMlkmi44GGWuGYFuTP5H
         6rQ9Ps2fDrkc9OVu0zAxbauaVCy2R7KumS2qZA3LRDYhjrL97S4qCg+P7hfQUiH9b3p3
         AvdrBp6NmFdTh5ceJSTxqdlVZ4i05t2uvAuBgggU88VqJKU6+7wZu2VyH4oQVK620F2h
         82/26fonqJQ9t9Jj2QTN2hUKXLN+BsljuiCaKLgS//hfUxI9RqQfXeuF9RVI5eZQ+Tfl
         0odOSnSLtgS/u5kqg4l8gXMILa4VVdhqgc/8LtU9UAus4tDvfdudq0oEoa4BqDW+cQen
         dCCg==
X-Gm-Message-State: APjAAAUCfFGumouB7ENrio0+02qxzahqrrfQJkFixN4CtHFqGOgDo3x/
        G+nVamjrDnXX4UWzC6BI4Ug=
X-Google-Smtp-Source: APXvYqwBsCVPsqsfupGeKiJu95wZVLEP+L74pOgPZfREy8gsL3RJl0ihNCED0LHxiC6jnW/YplyTlg==
X-Received: by 2002:a17:90b:1256:: with SMTP id gx22mr10197571pjb.94.1582982155535;
        Sat, 29 Feb 2020 05:15:55 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id z127sm14001861pgb.64.2020.02.29.05.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 05:15:55 -0800 (PST)
Date:   Sat, 29 Feb 2020 18:45:53 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200229131553.GA4985@afzalpc>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v3 has been posted w/ following changes,

1. Avoid unnecessary derefencing w.r.t irq name in pr_err
2. Modify pr_err() string so as to display in the form similar to,
        "Failed to request irq 2 (cascade)"
3. More commit message massage

Above are based on tglx feedback & would be applied to all patches in
addition to rearranging as required in other patches for readability.

Specific to m68k, following changes has been made based on m68 family
;) feedback,

1. Catch the errror code & display the symbolic error name usin "%pe"
format specifier
2. irq # in pr_err (already covered by following pt 2 pattern above)
3. s/pr_err/pr_debug

No altering of control flow based on error value has been done.

Regards
afzal

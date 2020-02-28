Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99797C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEF6246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1NUSuNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgB1XwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:52:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40165 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:52:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id t24so2296692pgj.7;
        Fri, 28 Feb 2020 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lObB5JCBCZhDuMW6ABx5wSPImicEEseX7SpFIrRo5gQ=;
        b=X1NUSuNESyn6IgvOLEv8n+zxO0ae3gnQQLrKpGT8U2+ycsKzztwAf9UQQwCCgKMaHC
         oq5DP4fJieJ3KkJCPQgqG4j+2sxH7jFUE3Daxal6PNHMAwdZzNvCQWdSwsTUCZ9ASuxe
         VvuflLRdiy+jXFNXF7yERmnENZsJUCPpEzMP7rrlND66XXedcgcrl5rbXhwf1p+sw69d
         8oEh45xhjCQFK9afR2pnX74Bgt1dwbig8bPXs3+6Tf45dR6LsQWLAUofF7/m1ZqPG2YE
         8zthovU0LcQEPaI8105kHJ4gQcVZFKlPdWVmYkff41yTg872HHClowdiGfTcy57h7TNU
         qFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lObB5JCBCZhDuMW6ABx5wSPImicEEseX7SpFIrRo5gQ=;
        b=mFwf3DfONyqFSDBguuYYm+PXMMTOBR/KuRPskpcrBLnG9YbCpPS3FAgtSMYNpgZ5dp
         dZiq4Gn5oGTyZ8sg44jJWVfRQ62chnlTJi/MvGdev7Z7XCKsJOtLHZQ4gJXJnJrGMEwU
         jG6EPc3tUCoHYsCGEpt/+rkQTc1Fpszit6ZTSbI1B1W5nCbvnEMa0QmY4APh66rpA2m8
         i6yAMgJJCBb1s5Pfd+pz+lDbg8ls/5SakDv4R1czeeQ2iULz2YhwEHWJYd58qkTeFXCX
         UfPiv7bkM/i7oDjEjhVu7qqgCJBzGVDGSLB8BiP6TQgqKzu9myUFOlDvjQsiqn6Fv4or
         1WfA==
X-Gm-Message-State: APjAAAUkGwG5LiXX5Z7lWAMKeA7D+xGYMR4HLSNqPn88moXh8vYbFF3A
        iwh3W/hoH8kTPhmpGvJgPMsltXQzais=
X-Google-Smtp-Source: APXvYqyhMt+jHV/EGDHeeKnn4DGz2gcI8obZzx0YM7gVZ547xqjm80CytqPCRWNKTG/JChQb3KdxZQ==
X-Received: by 2002:a63:5f51:: with SMTP id t78mr7033121pgb.362.1582933933245;
        Fri, 28 Feb 2020 15:52:13 -0800 (PST)
Received: from raspberrypi (72-48-120-28.static.grandenetworks.net. [72.48.120.28])
        by smtp.gmail.com with ESMTPSA id x26sm12623982pfq.55.2020.02.28.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:52:12 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:52:06 -0600
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, adam.vaughn.xh@renesas.com,
        zaitsev@google.com
Subject: Re: [PATCH] hwmon: (pmbus) Add support for 2nd Gen Renesas digital
 multiphase
Message-ID: <20200228235206.GA3468@raspberrypi>
References: <20200228212349.GA1929@raspberrypi>
 <20200228225848.GA14676@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228225848.GA14676@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for your expedient review. I will need to consult with my
coworkers to determine a more appropriate driver name. In the meantime I
will make the desired changes and I will also create a document for the
driver, which I will submit as a linked but separate patch.

With regard to the part numbers, this family of parts is currently in
the process of being released and we have not yet published all of the
corresponding datasheets. However, I have been assured that all of the
parts listed are slated to have a datasheet published publicly in the near
future.

Thank you,
Grant

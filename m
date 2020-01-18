Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F27C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 04:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E37F2192A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 04:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he/HqRKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAREHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:07:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55236 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAREHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 23:07:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so4047155pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 20:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIRa3Me1MuVP3scCn41TBw4mEuh3lRWcGYrwRLyuooo=;
        b=he/HqRKhdajTtzeAyutff/zMg8NhVoykxV8x8Lct0t2F+5QE+FJpEcsML/xjMv9DhO
         d21j+fpDGqrbXw7sgfg6XBrVGM6pQXGxJYD69E/6oWwKB7VW+++zgPYaSn6XywzMLSic
         VrvW06fTfC36SWN63zIYrFvMYdjpmV/s0tNervXM7wL3DGp12Jm6dMqd4bVx05KuYPdH
         Gd9EbcwrRuP4JMT2O4ovdHD0R/moQ3zufVkLenWPKEFpBhvmVvhkMShTlNKhDwbit67H
         esBV168gY1H3UlDETGjx4uJ9oVKusU7pZha/xjH/cr/GBjdEE+U64cDt/Q8XyCV5tT5T
         FDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIRa3Me1MuVP3scCn41TBw4mEuh3lRWcGYrwRLyuooo=;
        b=e4IxjhRy0syf2au0NAmaZlA0e+5M6DGFt9uKK+H8KWptXSmLEiyLtpQ0x/9k+IFLbO
         9TH8L7abJpAHnj1yKfiTeHYb/7E4ZFlyOaTu1uDLxmv/fUdxe+AwTSGuaLGymAigbzo9
         EDroO1qdk5MpPTG9TUnlYhYOoSesTHvSAaLNdBP/HpKeMXhJ8Ikb/m0j9Vf7KCviJ3+t
         eEiUR7Tbwd3MwXoIKdhwTq3DPgM+4Nda8n/0SPAx5zD9krV8Mq0Ejz2/wDJiVQ+PdQVz
         5H+quuUi4Pc4Zu1LViLUbFqYkA1XyvybwHKn2ZWvcXYwpPTu1bt6RhkRojVF+lhzyOcg
         p8Ew==
X-Gm-Message-State: APjAAAUkZVl0aN0HnrydQDtoEZo3YFImaIYF14Zg2gTTM1VS7xWlVCZo
        p7p8rcLWUDMp+2t8yrHnwu8=
X-Google-Smtp-Source: APXvYqzn4rsu/9mzBMbb1i9gkk/w2Y1AZ9IYMLGgk0U3+gBrOS0TVCTIxhXEQRQCTFVx+2cV2J+Y+g==
X-Received: by 2002:a17:902:b212:: with SMTP id t18mr2853630plr.135.1579320459261;
        Fri, 17 Jan 2020 20:07:39 -0800 (PST)
Received: from workstation-portable ([146.196.37.181])
        by smtp.gmail.com with ESMTPSA id c18sm30565333pfr.40.2020.01.17.20.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 20:07:38 -0800 (PST)
Date:   Sat, 18 Jan 2020 09:37:30 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     santosh.shilimkar@oracle.com, arm-soc <arm@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] drivers: soc: ti: knav_qmss_queue: Pass lockdep
 expression to RCU lists
Message-ID: <20200118040730.GA6783@workstation-portable>
References: <20200117133048.31708-1-frextrite@gmail.com>
 <5d77df7f-8693-0232-dbfe-0acfc37e040f@oracle.com>
 <20200117192555.baoxu4xd7krxgfjz@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117192555.baoxu4xd7krxgfjz@localhost>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:25:55AM -0800, Olof Johansson wrote:
> On Fri, Jan 17, 2020 at 10:24:04AM -0800, santosh.shilimkar@oracle.com wrote:
> > On 1/17/20 5:30 AM, Amol Grover wrote:
> > > inst->handles is traversed using list_for_each_entry_rcu
> > > outside an RCU read-side critical section but under the protection
> > > of knav_dev_lock.
> > > 
> > > Hence, add corresponding lockdep expression to silence false-positive
> > > lockdep warnings, and harden RCU lists.
> > > 
> > > Add macro for the corresponding lockdep expression.
> > > 
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > ---
> > > v2:
> > > - Remove rcu_read_lock_held() from lockdep expression since it is
> > >    implicitly checked for.
> > > 
> > Looks fine to me.
> > 
> > Hi Olof, Arnd,
> > Can you please pick this one and apply to your driver-soc branch ?
> > I already sent out pull request and hence the request.
> 
> Hi,
> 
> Can you please email the whole patch with sign-off to
> soc@kernel.org? Otherwise it won't end up in patchwork, which is how we track
> patches and pull requests these days.
> 

Thank you Santosh and Olof. I'm resending the patch to soc@kernel.org
as well.

Thanks
Amol

> 
> Thanks,
> 
> -Olof

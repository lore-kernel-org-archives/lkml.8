Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EDC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596C421582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="V07u5up/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgAQT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:26:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42577 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:26:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so27590075ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWPxiqs2+iCS7ywgBZoPdcaP9J/JZnx6nY7cUof021c=;
        b=V07u5up/I77H9UHL2RgtE8EgTvlvwfaEFYjFWyiW4+y3mmsf6hSpIL9mWxuD8JIASe
         3SSst9qoCTXer85nAaDXwyv/YnBEnPFcdRJ2ybjqyOWOd1gg/3Kd6GrFQfpNmDHi/BMP
         w0ZMrjYcUe+KlA5/lADOtOVfp712SacxUQBPD0QJjcff8V1bsR+QbUjR7dOF/lb0NN96
         usrzIqp2q/vX/xCnYHVsNkAn2erp5+VtyzupP9SaaEZ0FD1ww/8EO+YxsI5seKUG4Cw8
         5CMzNcoox5gW2zipArH3pjEATR80XUQuLFCaEDPaEVYFZGTyxdW97XFsH/XH+eENVwM2
         htDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWPxiqs2+iCS7ywgBZoPdcaP9J/JZnx6nY7cUof021c=;
        b=aTNQQEELczKTf7XZQI64oIiWUp1LlmzP2QmMrart80PNTGvIazqg5ob0p/DehaeJXU
         gnSOPDIvaBpdkNG4awjZyJ8lyfqEzQ0zCwd9IEpPp61oUDo4ZpiBTlam3qehDXImv/G7
         o2O+nXRhPN9EjS7kRlfJiny8O1sp3BcJ1Hr/f1KwXnBva/yTApSNUUWiLEN/DDhRBe0Z
         kNXfjRGRfYCS0IEb8T6oQtoJxsVGjYtiPqP7tVsufprHncgHXUCgNSigBaPdLvI52V8k
         ismx+ZMpI3gVVoeR5p1DnWHsD6pQqHYGLXOl87b08ff9zvkYAx+QYWJX+QrGZfgGMoVV
         dtWg==
X-Gm-Message-State: APjAAAVxgg0dPNTIERFfR42jEp1YSZ0qXmmp3rznA33IlrGxeQnOP2Pk
        n+mwsCOGOcJci51gwt1M8WrN/g==
X-Google-Smtp-Source: APXvYqxdevK1ARk4iG2CURRwB6/qFK6i8RWBWNjzDcLM/Zn5XeE+WkyCWl8OJDp7suwJT87EBjEJlw==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr6192574ljg.223.1579289207431;
        Fri, 17 Jan 2020 11:26:47 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id w29sm12592801lfa.34.2020.01.17.11.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 11:26:46 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:25:55 -0800
From:   Olof Johansson <olof@lixom.net>
To:     santosh.shilimkar@oracle.com
Cc:     Amol Grover <frextrite@gmail.com>, arm-soc <arm@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] drivers: soc: ti: knav_qmss_queue: Pass lockdep
 expression to RCU lists
Message-ID: <20200117192555.baoxu4xd7krxgfjz@localhost>
References: <20200117133048.31708-1-frextrite@gmail.com>
 <5d77df7f-8693-0232-dbfe-0acfc37e040f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d77df7f-8693-0232-dbfe-0acfc37e040f@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:24:04AM -0800, santosh.shilimkar@oracle.com wrote:
> On 1/17/20 5:30 AM, Amol Grover wrote:
> > inst->handles is traversed using list_for_each_entry_rcu
> > outside an RCU read-side critical section but under the protection
> > of knav_dev_lock.
> > 
> > Hence, add corresponding lockdep expression to silence false-positive
> > lockdep warnings, and harden RCU lists.
> > 
> > Add macro for the corresponding lockdep expression.
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> > v2:
> > - Remove rcu_read_lock_held() from lockdep expression since it is
> >    implicitly checked for.
> > 
> Looks fine to me.
> 
> Hi Olof, Arnd,
> Can you please pick this one and apply to your driver-soc branch ?
> I already sent out pull request and hence the request.

Hi,

Can you please email the whole patch with sign-off to
soc@kernel.org? Otherwise it won't end up in patchwork, which is how we track
patches and pull requests these days.


Thanks,

-Olof

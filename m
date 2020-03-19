Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A0C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F932072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584637973;
	bh=+suaTuyvFSVo+mbQOYJZsHrWdUe3OakpeHo8H+U6fNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IEbwJi9owwPEBmbr5K4tMg50Ra9lCC3lr3X77WXaF8hcRydcEnXBl3Fm2yhaB1InT
	 qGhxEBmrWwe49WOpzWO40ELwrkcB82Ppm3Prs0HJllknrmyiilkwpS2N/39B4llP84
	 CdlSlIscYsXOGVHk1jC5PLLXCMq3UXSSXmXmw3rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgCSRMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:12:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35177 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCSRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:12:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id u12so3406951ljo.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGnzjLPuiF5jh+YmVcnbPs/rygoBzTtr0yQpmvu1C/U=;
        b=ho5WkQIp7FBmmWnNEs8qarjlXHQ/bMpYIjVlz5diN+cFqHjIA9Cfpaie2yvrq56MzY
         6TnA04IH3cBRxYREMcsiPUpLCig/QPzuawQ7+ZDABjg2D7iZ5uNSWio6VnyJC48k22lp
         9sUOw53EsymdqqmachpMBK4cZKv94z+KiqobI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGnzjLPuiF5jh+YmVcnbPs/rygoBzTtr0yQpmvu1C/U=;
        b=tAr2X2Kmm5+lqNLTdtHFVa8pHx7bxXvSbVEBSRd/lbmxytUxmJBwAUjcGw1znXYuuk
         XmJY4D67DDys+0oXHfmYTalkSiQ1KWHrsl9KwiIAJ4bsZ5xLuX7GW8V0fiXtl6ldS61N
         UtDspLakqFtfCb0nL+ldtJdbfO3NY6jeTQD6LSPBu5bHw4B60LYvXHERvxUrct+Wu1gK
         ybgRSXEiDTGE/C+a6hZcPqcpagDRzBZ8je++h6sFK0z/cy7NG1HIMrTuuH7uJ6LTUyIy
         Wm2ByadHUlO7bUoPhLEIZGsSG4BU+IOdlSRxVYhtEjRnPXzE024nVUxyZGAaXPDwDDr/
         pKZg==
X-Gm-Message-State: ANhLgQ3wwW3+dRmVSR8RyozTrceGLCW708ON5iRlK8bN/e7piy1OLAoR
        lUl9y7ycLoCpiPO/boSrwiqUlVANYBI=
X-Google-Smtp-Source: ADFU+vuaxecHxqORHoeSBf9L/bB9ihaY107tqVlV7JMa4E3uxAydEGgsvhtJbL23hCpYI7srAF2gkw==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr2680621lji.182.1584637967590;
        Thu, 19 Mar 2020 10:12:47 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m15sm1851901ljo.8.2020.03.19.10.12.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:12:46 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t21so2263966lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:12:46 -0700 (PDT)
X-Received: by 2002:a19:c7:: with SMTP id 190mr2779646lfa.30.1584637965843;
 Thu, 19 Mar 2020 10:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200318204302.693307984@linutronix.de> <20200318204408.521507446@linutronix.de>
In-Reply-To: <20200318204408.521507446@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Mar 2020 10:12:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3bwUD9=y4Wd6=Dh1Xwib+N3nYuKA=hd3-y+0OUeLcOQ@mail.gmail.com>
Message-ID: <CAHk-=wj3bwUD9=y4Wd6=Dh1Xwib+N3nYuKA=hd3-y+0OUeLcOQ@mail.gmail.com>
Subject: Re: [patch V2 11/15] completion: Use simple wait queues
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 1:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is no semantical or functional change:

Ack, with just the explanation, I'm no longer objecting to this.

Plus you fixed and cleaned up the odd usb gadget code separately
(well, most of it).

              Linus

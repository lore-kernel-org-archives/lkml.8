Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C608C3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2495A24658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582065625;
	bh=p7rSRm9UPH0+2uZT8yWNgKBnY+oWwj14kDnc9nBF6zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zfvFOkjeYenXQW3VKpBVHVxbn4ARIpGFQV2qdNZTpzIeTQoJ2z2FXZLv1e0UpBenR
	 DvbCDA7Ieid3UUg5IlaMRG/exJCjWWuNbLhq9BRikLb14DRaFeSmalhHz7SqcBmAyp
	 czHDt8DRHacysMglFZXL8imD/raHE68Cvp+JOFPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBRWkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRWkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:40:23 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90B12173E;
        Tue, 18 Feb 2020 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582065623;
        bh=p7rSRm9UPH0+2uZT8yWNgKBnY+oWwj14kDnc9nBF6zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBx/zh3fmezbuYuPWdANnkExjb3/eMfo2G7n40lFWiWAlH9WG3zJiD3S3HESWB4+d
         ruyyxzHLgEvINJw31KdZMLWsIHOHL+YkuhtmSa4dVADKmbGONYvIpW/5wl9C/mWQ5Q
         JZBnGUhQCJ/KGlCEQkb6DJq/grRb7DGd8mP3nteg=
Date:   Tue, 18 Feb 2020 23:40:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, paulmck@kernel.org
Subject: Re: [RFC] #MC mess
Message-ID: <20200218224019.GA13978@lenoir>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
 <20200218203404.GI11457@worktop.programming.kicks-ass.net>
 <20200218214904.GD11802@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218214904.GD11802@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:49:04PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 09:34:04PM +0100, Peter Zijlstra wrote:
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index da0af631ded5..146332764673 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -71,7 +71,7 @@ extern void irq_exit(void);
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> -		BUG_ON(in_nmi());				\
> +		BUG_ON(in_nmi() == 0xf);			\

I guess you meant:

  BUG_ON(in_nmi() == NMI_MASK);

Thanks.

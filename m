Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1542C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7095206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aq+bhGjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgHKGpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:45:51 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64139 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbgHKGpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:45:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597128350; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=qaD0uP3479tOBE0W+RFgHcukoSHpOeQAxStJYz/hn1I=; b=aq+bhGjtjGejAvXAcU4cnU5FhoASzZ8mT4YgtFaSSrj28cdToFou2ehxK13S+Lokamt+v20s
 1LcKSxsaydytHRUtxla8pEm7QTG5/q63Qr9xS507pwHKmva0HuWzB9RdwdhnSUYwbVa1RjYU
 XM038BUgaYQ4tdZLC9yw8MOxo+o=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f323e973f2ce110203c104b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 06:45:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C890C433CB; Tue, 11 Aug 2020 06:45:43 +0000 (UTC)
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AB43C433C6;
        Tue, 11 Aug 2020 06:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AB43C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 11 Aug 2020 14:45:29 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200811064529.GA4253@codeaurora.org>
References: <20200728013359.2326-1-tingwei@codeaurora.org>
 <20200811030418.GA1893@codeaurora.org>
 <20200810231954.3388855c@oasis.local.home>
 <20200811034946.GA9338@codeaurora.org>
 <20200811000333.5d24b16f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811000333.5d24b16f@oasis.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:03:33PM +0800, Steven Rostedt wrote:
> On Tue, 11 Aug 2020 11:49:46 +0800
> Tingwei Zhang <tingweiz@codeaurora.org> wrote:
> 
> > On Tue, Aug 11, 2020 at 11:19:54AM +0800, Steven Rostedt wrote:
> > > On Tue, 11 Aug 2020 11:04:18 +0800
> > > Tingwei Zhang <tingweiz@codeaurora.org> wrote:
> > >   
> > > > Thanks for your comments, Steven.  I've addressed all your comments
> in  
> > > v3.  
> > > > Do you have more comments on v3? Is there anything I need to do to
> merge
> > > > this series to Linux Kernel?  
> > > 
> > > I gave my Reviewed-by tag on each of the patches that touch my tree.
> It
> > > should go in via whoever maintains the drivers/hwtracing tree. Is that
> > > Greg KH?  
> > I thought it will go to tracing tree since majority of the changes are
> in
> > kernel/trace.
> > 
> > Maintainers of drviers/hwtracing are Mathieu and Suzuki. I'll add them
> > into review list.
> >
> 
> As I didn't have reviews or acks from them. I couldn't take the code.
> When touching two subsystems, it usually requires one of the subsystem
> maintainers to ack the changes to their subsystem, so that the other
> subsystem maintainer can take the rest of the code through their tree.
> 
> And it usually goes through the tree that has the interface that is
> changing.  That is, the changes to tracing was the infrastructure
> needed for the changes in the hwtrace subsystem. And I don't test that
> subsystem, so I wouldn't really be able to test this code.
> 
Thanks a lot for detail clarification, Steven.

Thanks,
Tingwei

> -- Steve

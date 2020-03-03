Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87EDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2E20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3BWJ1Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCCHvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:51:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LWDpu0pQ+3AjL26hdj7oM9e1WSlMSaxHS4mjk1wiZQs=; b=c3BWJ1PoJXoQF/aKZv90DK2ISI
        vObZhPG5gpxNvjGUaqHJAsY/AJ3umwM4cFdA2XRA5NJg2dUnQtJgE8w70FKiNxZrMXq4lh2Yi6EiH
        g6jwW10zip6A9bwFvVRFP0qBqtgKpyryjrVgz06wzruhKWsO6p9b9b7AUwwCyMz8DtSDGvN0W3cS1
        jTIHRr1ISGUPnGqv6Jrmlkn7u6Rz9FS7gy3oUi4N9ycuhNhYo26WVjJPZh4oakFA3xL3SKrC3tppg
        VlpAJ0s9/nriXknTN/HwAbzb458moCyEtYjUsWSyG41XQdkDPb40kzvZMOUujEErqnI0I7cs11hiz
        pnhiQPUA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j92LC-0005hQ-7Y; Tue, 03 Mar 2020 07:51:46 +0000
Subject: Re: [v3] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
 <158313622831.3082.8237132211731864948.stgit@devnote2>
 <8c032093-c652-5e33-36ad-732f73beabab@infradead.org>
 <12200e6e-2ef0-a0e4-9d92-35d7150342d2@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d79b5810-7445-9c91-cd0f-99c45195ba3b@infradead.org>
Date:   Mon, 2 Mar 2020 23:51:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <12200e6e-2ef0-a0e4-9d92-35d7150342d2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 10:52 PM, Markus Elfring wrote:
>> All of the other changes look good to me.
> 
> I suggest to take another closer look.
> Would you like to help with the clarification of any remaining
> software documentation concerns?

There are a few other things that I would change, but I don't think
that they are showstoppers.

-- 
~Randy


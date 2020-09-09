Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4007C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A421D43
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UWbrv9rs";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GZZ4fKZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIIUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:45:59 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:50164
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599684353;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=F3KC+UymvTZDdP36/YRuUrSRkL0TNi3D0l8uAgEu05c=;
        b=UWbrv9rsKuGzOH1fWRjl0YAeol7LJ4qsQ0MCN69/0bGG7U+/OIHwyysCFzKmc4Ia
        ZTwLe0TJ8tKc25dKGWjbUzze/4UdlirCn+EJo/q4NBqCv1T0h/sC+Ltf8FFnm6Yqkw0
        BrTZury5K7WIbOqAutPPdG970UXIRp5fI+Ycg8X4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599684353;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=F3KC+UymvTZDdP36/YRuUrSRkL0TNi3D0l8uAgEu05c=;
        b=GZZ4fKZ6I42jDmvUicdzEZgwMQQluiKWA0PVhSedAEC1UlzyqCXDJpH/KQmB7Ugr
        tbP2bnnqlbSrSb7NBtW9KH+a40e049MtomhsfsG4zFLrB4jl9511PmTb9ZlxD7xQyoo
        fy7KFULTPYYdsHAYy3HR5rQ3DgjSJdwOwInHo+co=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 9 Sep 2020 20:45:53 +0000
From:   tsoni@codeaurora.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tingwei Zhang <tingweiz@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v9 00/24] coresight: allow to build coresight as modules
In-Reply-To: <20200909161523.GA553266@xps15>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
 <CANLsYkwhypfEkmhg=wK+_F6TxxGiuoSqpgGR0REqsOqC-X-3mg@mail.gmail.com>
 <0101017470c9475d-00e296fc-1173-4afa-95cb-22ac70d85d5b-000000@us-west-2.amazonses.com>
 <20200909161523.GA553266@xps15>
Message-ID: <01010174749e1e01-e99c3e27-f22b-4b22-83a7-36c0b86c5bdd-000000@us-west-2.amazonses.com>
X-Sender: tsoni@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.09-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-09 09:15, Mathieu Poirier wrote:
> On Wed, Sep 09, 2020 at 02:54:33AM +0000, Tingwei Zhang wrote:
>> On Wed, Sep 09, 2020 at 01:53:51AM +0800, Mathieu Poirier wrote:
>> > Hi Tingwei,
>> >
>> > Apologies for the untimely response to this set, I am hoping to get to
>> > it in the next two weeks.
>> >
>> 
>> It's fine, Mathieu. Please let me know your comments once you have 
>> time.
>> I'm targeting to get these set merged in 5.10 Kernel.
> 
> From the above it is not clear if you want this set to be _in_ the 5.10 
> cycle
> or added to my list _during_ the 5.10 cycle, which would make it part 
> of the
> 5.11 cycle.  In any case the latter seems more realistic.

Tingwei can correct me here, but we prefer to have patches to be part of 
the 5.10 release. It means they should get merged in Linus's tree in the 
next merge window.

---Trilok Soni

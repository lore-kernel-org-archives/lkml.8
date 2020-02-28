Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC0A24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="NEiDULsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgB1TnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:43:09 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:47447 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgB1TnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:43:09 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EA7D623E29;
        Fri, 28 Feb 2020 20:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582918986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2ab2OB2vekcnc12mpz1Vb1OABfvPHjtiVIVlnMRJR0=;
        b=NEiDULsxgUwpmlyHefAr36t7P4AKbtXKrFb2W7hE5ZDUC2Ob0iy3Lv0gW2i8cXvx/7Ok45
        AKtyigMsI/yrzT/yLWLDf3LZlFpdeugLDH8mAk/QO77OkW1xzP57TQnt1Ltqj6VMdjwDjU
        5oKFR3GLB2pxu+rKwaG3poaiBxgO0aM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Feb 2020 20:43:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v2 0/2] AT8031 PHY timestamping support
In-Reply-To: <20200228181507.GA4744@localhost>
References: <20200228180226.22986-1-michael@walle.cc>
 <20200228181507.GA4744@localhost>
Message-ID: <979b0b89b2610c105310e733e98cd862@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: EA7D623E29
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Am 2020-02-28 19:15, schrieb Richard Cochran:
> On Fri, Feb 28, 2020 at 07:02:24PM +0100, Michael Walle wrote:
>>  (1) The PHY doesn't support atomic reading of the (timestamp,
>>      messageType, sequenceId) tuple. The workaround is to read the
>>      timestamp again and check if it has changed. Actually, you'd have
>>      to read the complete tuple again.
> 
> This HW is broken by design :(

Yeah, I know. And actually I don't think I'll pursue this further. Like 
I
said, I just wanted to my current work. Maybe it will be useful in the
future who knows.

>> But if you're using a P2P clock with peer delay requests this whole
>> thing falls apart because of caveat (3). You'll often see messages 
>> like
>>   received SYNC without timestamp
>> or
>>  received PDELAY_RESP without timestamp
>> in linuxptp. Sometimes it working for some time and then it starts to
>> loosing packets. I suspect this depends on how the PDELAY messages are
>> interleaved with the SYNC message. If there is not enough time to 
>> until
>> the next event message is received either of these two messages won't
>> have a timestamp.
> 
> And even the case where a Sync and a DelayResp arrive at nearly the
> same time will fail.
> 
>> The PHY also supports appending the timestamp to the actual ethernet 
>> frame,
>> but this seems to only work when the PHY is connected via RGMII. I've 
>> never
>> get it to work with a SGMII connection.
> 
> This is the way to go.  I would try to get the vendor's help in making
> this work.

Like I said, our FAE is pretty unresponsive. But I'll at least try to 
find
out if my guess is correct (that it only works with RGMII). But even 
then,
how should the outgoing timestamping work. There are two possibilities:

  (1) According to the datasheet, the PHY will attach the TX timestamp to
      the corresponding RX packet; whatever that means. Lets assume there
      is such a "corresponding packet", then we would be at the mercy of 
the
      peer to actually send such a packet, let alone in a timely manner.
  (2) Mixing both methods. Use attached timestamps for RX packets, read 
the
      timestamp via PHY registers for TX packets. Theoretically, we could
      control how the packets are send and make sure, we fetch the TX
      timestamp before sending another PTP packet. But well.. sounds 
really
      hacky to me.

-michael

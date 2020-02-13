Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B236C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00092206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Rx/UwHRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IM0u8gjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgBMCSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:18:48 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39799 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbgBMCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:18:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0A2D878DD;
        Wed, 12 Feb 2020 21:18:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Feb 2020 21:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=j
        oc0nTBS0TrHM54svde7hMgF2xPWZMi+owrnjYj7liY=; b=Rx/UwHRdOA1f9RDtl
        eJ8JHrcLGDopY14a4t2TS0h3umQgzyc/G7VJe51GZRrOcr4XoCFWj7VxFYwnFTqb
        gDQNXnxEe0UyUdAaV3zaTlycM6km+m75YxM6vB/fP6oxXkDz2gikfJ4YayCXrBhq
        rsobyCkqSthx2+BpE8qVLjJVcRVZ4DU4Gmesa7TL445XRheFIba6B1f6nzoMFX9R
        khG62mPfFdi65tjiIQ8injRarUd6K8iSi4fab/22ybBWpDZEOy4UAU15ZCxwSB27
        X6+sKoKSCsRcieLPcrItvcssr0OkoO01vb3FH8iW47mvoc8vMX7DydGYQLqpiyfw
        ZX6KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=joc0nTBS0TrHM54svde7hMgF2xPWZMi+owrnjYj7l
        iY=; b=IM0u8gjq6Nx2Kq3y6QyAmNzZALo7IqzIVcjwPX29Mu0sfZd/j+LBI5BuK
        NBrHQ4Kmq/nXJIxrWfdwOqwAI3vfNysKdtF/fKZyanDh0R3E7dnUp2THhxJUWxx1
        g1F+AVgGBIM5WY3CkomMYpce3X+AJhKVlZKso7McGpeBqPjDfV/HY25hutiHHaLG
        BI8yo/CSgUSo/LTDeC51N/LHh7FwFWKSoSoo6Ms71VsFg/JYC2Qi1WD9W+p2CuKr
        BZFKIouEVJbfiB91ycQK1Yfv5rEUj5DbM/Dzkbnm1KFMrBk4ANAz/8gkqzt5h0Mo
        6zC/9Q+Y6LvzPN63LQGP68YArlyPw==
X-ME-Sender: <xms:A7JEXiDhq3vNUpm1iwmErhJKYISlmFQrpF18JXFuvtLoLgoDVUWCfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:A7JEXsp6-cuLogGtsnvIq6QKkjQ5fW4Z48eG1WOfh25ScmSRDshzXA>
    <xmx:A7JEXjYimVazaqIpFZanF45QZwfXocCNb-zXaq0Tq-9DQC9XFjJY-g>
    <xmx:A7JEXlBUrWWXn6VNdng-gSFCpjlSt4Gt-Equ-M5b5RpMHEht2Zqr4A>
    <xmx:B7JEXpfG-8lHDlD5iD3yJQeoYpIkQezQELfiTqWLI53Gb-ze_SgjuA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E89130606E9;
        Wed, 12 Feb 2020 21:18:42 -0500 (EST)
Subject: Re: [PATCH v6 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20200113051852.15996-1-samuel@sholland.org>
 <20200113051852.15996-3-samuel@sholland.org>
 <CABb+yY2MJ-1i0K7XVkPT3+6ac1XR9-3zf-GDNeswOMp6Zn_Ufw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <72dc2074-c06d-4bdf-ca5f-b4007f492407@sholland.org>
Date:   Wed, 12 Feb 2020 20:18:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABb+yY2MJ-1i0K7XVkPT3+6ac1XR9-3zf-GDNeswOMp6Zn_Ufw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jassi,

On 2/12/20 8:02 PM, Jassi Brar wrote:
> On Sun, Jan 12, 2020 at 11:18 PM Samuel Holland <samuel@sholland.org> wrote:
>>
>> +static int sun6i_msgbox_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
>> +       int n = channel_number(chan);
>> +       uint32_t msg = *(uint32_t *)data;
>> +
>> +       /* Using a channel backwards gets the hardware into a bad state. */
>> +       if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
>> +               return 0;
>> +
>> +       /* We cannot post a new message if the FIFO is full. */
>> +       if (readl(mbox->regs + FIFO_STAT_REG(n)) & FIFO_STAT_MASK) {
>> +               mbox_dbg(mbox, "Channel %d busy sending 0x%08x\n", n, msg);
>> +               return -EBUSY;
>> +       }
>> +
> This check should go into sun6i_msgbox_last_tx_done().
> send_data() assumes all is clear to send next packet.

sun6i_msgbox_last_tx_done() already checks that the FIFO is completely empty (as
the big comment explains). So this error could only be hit in the knows_txdone
== true case, if the client pipelines multiple messages by calling
mbox_client_txdone() before the message is actually removed from the FIFO.

From the comments in mailbox_controller.h, this kind of usage looks to be
unsupported. In that case, I could remove the check entirely. Does that sound right?

> .....
>> +
>> +       mbox->controller.dev           = dev;
>> +       mbox->controller.ops           = &sun6i_msgbox_chan_ops;
>> +       mbox->controller.chans         = chans;
>> +       mbox->controller.num_chans     = NUM_CHANS;
>> +       mbox->controller.txdone_irq    = false;
>> +       mbox->controller.txdone_poll   = true;
>> +       mbox->controller.txpoll_period = 5;
>> +
> nit:  just a single space should do too.
> 
> Sorry, for some reason I thought I had replied to this patch, but
> apparently not. My mistake. Do you want to revise this submission or
> send another patch on top?

For just this change, it would be simpler to send a follow-up patch.

> thanks

Thank you,
Samuel


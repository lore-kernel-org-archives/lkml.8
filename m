Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BB3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B701B21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgATOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:01:54 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:45110 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgATOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:01:53 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1itXcf-00029R-ML; Mon, 20 Jan 2020 15:01:45 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 00KE1h5u024132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 20 Jan 2020 15:01:43 +0100
Subject: Re: [Bug ?] usb :typec :tcpm :fusb302
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
 <20200120115828.GC32175@kuha.fi.intel.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
Message-ID: <af987eda-9411-ef4f-b2ee-99cd24b04188@fivetechno.de>
Date:   Mon, 20 Jan 2020 15:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120115828.GC32175@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1579528912;255915b3;
X-HE-SMSGID: 1itXcf-00029R-ML
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Am 20.01.20 um 12:58 schrieb Heikki Krogerus:
> Hi Markus,
> 
> On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
>> Hi,
>> 
>> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
>> The board is powered from an USB-C type connector via an FUSB302 PD controller.
>> With measured 15W+ power consumption it should use higher voltage PD modes than
>> the standard 5V USB-C mode.
>> 
>> When I add the related connector node in DTS [2] the FUSB302 initializes
>> the right PD mode (e.g. 15V/3A).
>> 
>> But during initialisation the PD is switched off shortly and the board has a blackout.
>> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
>> I can remove the backup after succesfull setting up the PD and the board will run fine.
>> 
>> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
>> during init?
> 
> I guess it's also possible that the problem is with tcpm.c instead of
> fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
> you take a look at this?
> 
> Both tcpm.c and fusb302.c create debugfs entries that have a more
> detailed log about things that are happening. Can you check what you
> have in those (when you boot with the mains cable plugged it)?

With a "dumb" 5V/5A-USB-C supply all is well, no logs included here, but I can supply them.

With a 30W PD-supply plugged in plus a backup supply after USB-C to avoid shutdown
and be able to get the following logs.
(With a 45W PD-supply the "mismatch" is avoided, but the shutdown occurs, too.)
> 
>          % mount debugfs -t debugfs /sys/kernel/debug
>          % cat /sys/kernel/debug/tcpm*
>          % cat /sys/kernel/debug/fusb302/*
>
# cat /sys/kernel/debug/usb/tcpm-7*
[    1.476213] Setting voltage/current limit 0 mV 0 mA
[    1.476217] polarity 0
[    1.476220] Requesting mux state 0, usb-role 0, orientation 0
[    1.477044] state change INVALID_STATE -> SNK_UNATTACHED
[    1.477135] CC1: 0 -> 0, CC2: 0 -> 0 [state SNK_UNATTACHED, polarity 0, disconnected]
[    1.477153] 7-0022: registered
[    1.484613] Setting voltage/current limit 0 mV 0 mA
[    1.484620] polarity 0
[    1.484625] Requesting mux state 0, usb-role 0, orientation 0
[    1.485475] cc:=0
[    1.490308] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms
[    1.515626] VBUS off
[    1.591858] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]
[    1.591877] state change PORT_RESET_WAIT_OFF -> SNK_UNATTACHED
[    1.591898] Start toggling
[    1.617555] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
[    1.617565] state change TOGGLING -> SNK_ATTACH_WAIT
[    1.617588] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
[    1.787923] VBUS on
[    1.819940] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 200 ms]
[    1.819963] state change SNK_DEBOUNCED -> SNK_ATTACHED
[    1.819972] polarity 1
[    1.819979] Requesting mux state 1, usb-role 2, orientation 2
[    1.821297] state change SNK_ATTACHED -> SNK_STARTUP
[    1.821329] state change SNK_STARTUP -> SNK_DISCOVERY
[    1.821339] Setting voltage/current limit 5000 mV 3000 mA
[    1.821348] vbus=0 charge:=1
[    1.821363] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES
[    1.828113] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 240 ms
[    1.886496] PD RX, header: 0x5161 [1]
[    1.886512]  PDO 0: type 0, 5000 mV, 3000 mA [E]
[    1.886521]  PDO 1: type 0, 9000 mV, 3000 mA []
[    1.886530]  PDO 2: type 0, 12000 mV, 2500 mA []
[    1.886539]  PDO 3: type 0, 15000 mV, 2000 mA []
[    1.886547]  PDO 4: type 0, 20000 mV, 1500 mA []
[    1.886554] state change SNK_WAIT_CAPABILITIES -> SNK_NEGOTIATE_CAPABILITIES
[    1.886581] cc=0 cc1=0 cc2=5 vbus=0 vconn=sink polarity=1
[    1.886590] Requesting PDO 3: 15000 mV, 2000 mA [mismatch]
[    1.886597] PD TX, header: 0x1042
[    1.894100] PD TX complete, status: 0
[    1.894182] pending state change SNK_NEGOTIATE_CAPABILITIES -> HARD_RESET_SEND @ 60 ms
[    1.896256] PD RX, header: 0x364 [1]
[    1.896268] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_WAIT_CAPABILITIES
[    1.906436] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 240 ms
[    2.147890] state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND [delayed 240 ms]
[    2.147900] PD TX, type: 0x5
[    2.151425] PD TX complete, status: 0
[    2.151438] state change HARD_RESET_SEND -> HARD_RESET_START
[    2.156148] state change HARD_RESET_START -> SNK_HARD_RESET_SINK_OFF
[    2.156154] vconn:=0
[    2.156163] vbus=0 charge:=0
[    2.156171] Requesting mux state 1, usb-role 2, orientation 2
[    2.156956] pending state change SNK_HARD_RESET_SINK_OFF -> SNK_HARD_RESET_SINK_ON @ 650 ms
[    2.189388] VBUS off
[    2.189400] state change SNK_HARD_RESET_SINK_OFF -> SNK_HARD_RESET_WAIT_VBUS
[    2.189435] pending state change SNK_HARD_RESET_WAIT_VBUS -> SNK_UNATTACHED @ 1275 ms
[    2.999176] VBUS on
[    2.999182] state change SNK_HARD_RESET_WAIT_VBUS -> SNK_HARD_RESET_SINK_ON
[    2.999201] Setting voltage/current limit 5000 mV 3000 mA
[    2.999205] vbus=0 charge:=1
[    3.000125] state change SNK_HARD_RESET_SINK_ON -> SNK_STARTUP
[    3.000129] state change SNK_STARTUP -> SNK_DISCOVERY
[    3.000132] Setting voltage/current limit 5000 mV 3000 mA
[    3.000135] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES
[    3.005828] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 240 ms
[    3.099305] PD RX, header: 0x5161 [1]
[    3.099327]  PDO 0: type 0, 5000 mV, 3000 mA [E]
[    3.099341]  PDO 1: type 0, 9000 mV, 3000 mA []
[    3.099354]  PDO 2: type 0, 12000 mV, 2500 mA []
[    3.099369]  PDO 3: type 0, 15000 mV, 2000 mA []
[    3.099383]  PDO 4: type 0, 20000 mV, 1500 mA []
[    3.099393] state change SNK_WAIT_CAPABILITIES -> SNK_NEGOTIATE_CAPABILITIES
[    3.099433] cc=0 cc1=0 cc2=5 vbus=0 vconn=sink polarity=1
[    3.099461] Requesting PDO 3: 15000 mV, 2000 mA [mismatch]
[    3.099471] PD TX, header: 0x1042
[    3.106078] PD TX complete, status: 0
[    3.106191] pending state change SNK_NEGOTIATE_CAPABILITIES -> HARD_RESET_SEND @ 60 ms
[    3.110914] PD RX, header: 0x363 [1]
[    3.110926] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_TRANSITION_SINK
[    3.110954] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 500 ms
[    3.264307] PD RX, header: 0x566 [1]
[    3.264315] Setting voltage/current limit 15000 mV 2000 mA
[    3.264319] state change SNK_TRANSITION_SINK -> SNK_READY
[    3.769063] PD RX, header: 0x176f [1]
[    3.769072] Rx VDM cmd 0xff008001 type 0 cmd 1 len 1
[    3.769096] PD TX, header: 0x124f
[    3.778524] PD TX complete, status: 0

# cat /sys/kernel/debug/usb/fusb302-7*
[    1.467517] sw reset
[    1.471400] fusb302 device ID: 0x81
[    1.476199] pd := off
[    1.476204] vbus is already Off
[    1.476207] charge is already Off
[    1.476210] vconn is already Off
[    1.477020] pd header := Sink, Device
[    1.477131] cc1=Open, cc2=Open
[    1.484586] pd := off
[    1.484598] vbus is already Off
[    1.484603] charge is already Off
[    1.484608] vconn is already Off
[    1.485434] pd header := Sink, Device
[    1.485481] cc := Open
[    1.515593] IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x00
[    1.515603] IRQ: VBUS_OK, vbus=Off
[    1.600176] start drp toggling
[    1.609645] IRQ: 0x00, a: 0x40, b: 0x00, status0: 0x03
[    1.609684] IRQ: TOGDONE
[    1.617421] detected cc1=Open, cc2=Rp-3.0
[    1.617537] cc1=Open, cc2=Rp-3.0
[    1.787820] IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
[    1.787835] IRQ: VBUS_OK, vbus=On
[    1.821219] pd header := Sink, Device
[    1.821356] vbus is already Off
[    1.828079] pd := on
[    1.880511] IRQ: 0x41, a: 0x00, b: 0x00, status0: 0x93
[    1.880518] IRQ: BC_LVL, handler pending
[    1.882465] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    1.882475] IRQ: BC_LVL, handler pending
[    1.882483] IRQ: PD sent good CRC
[    1.886390] PD message header: 5161
[    1.886397] PD message len: 20
[    1.888273] sending PD message header: 1042
[    1.888281] sending PD message len: 4
[    1.890126] IRQ: 0x41, a: 0x00, b: 0x00, status0: 0xc0
[    1.890136] IRQ: BC_LVL, handler pending
[    1.892061] IRQ: 0x51, a: 0x04, b: 0x01, status0: 0x93
[    1.892071] IRQ: BC_LVL, handler pending
[    1.892077] IRQ: PD tx success
[    1.894088] PD message header: 161
[    1.894095] PD message len: 0
[    1.894112] IRQ: PD sent good CRC
[    1.896133] PD message header: 364
[    1.896151] PD message len: 0
[    1.898410] IRQ: 0x41, a: 0x00, b: 0x00, status0: 0x93
[    1.898421] IRQ: BC_LVL, handler pending
[    1.906419] pd := on
[    1.932440] BC_LVL handler, status0=0x93
[    2.150646] IRQ: 0x41, a: 0x08, b: 0x00, status0: 0x93
[    2.150655] IRQ: BC_LVL, handler pending
[    2.150660] IRQ: PD hardreset sent
[    2.156139] pd := off
[    2.156158] vconn is already Off
[    2.156167] vbus is already Off
[    2.156951] pd header := Sink, Device
[    2.184681] BC_LVL handler, status0=0x83
[    2.189232] IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x03
[    2.189254] IRQ: VBUS_OK, vbus=Off
[    2.999090] IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
[    2.999101] IRQ: VBUS_OK, vbus=On
[    2.999209] vbus is already Off
[    3.000119] pd header := Sink, Device
[    3.005815] pd := on
[    3.091471] IRQ: 0x41, a: 0x00, b: 0x00, status0: 0x93
[    3.091494] IRQ: BC_LVL, handler pending
[    3.094285] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    3.094308] IRQ: BC_LVL, handler pending
[    3.094320] IRQ: PD sent good CRC
[    3.099159] PD message header: 5161
[    3.099176] PD message len: 20
[    3.101380] sending PD message header: 1042
[    3.101398] sending PD message len: 4
[    3.103705] IRQ: 0x41, a: 0x04, b: 0x00, status0: 0xd2
[    3.103723] IRQ: BC_LVL, handler pending
[    3.103734] IRQ: PD tx success
[    3.106057] PD message header: 161
[    3.106070] PD message len: 0
[    3.108454] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    3.108473] IRQ: BC_LVL, handler pending
[    3.108482] IRQ: PD sent good CRC
[    3.110798] PD message header: 363
[    3.110812] PD message len: 0
[    3.144489] BC_LVL handler, status0=0x93
[    3.262142] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
[    3.262151] IRQ: BC_LVL, handler pending
[    3.262157] IRQ: PD sent good CRC
[    3.264203] PD message header: 566
[    3.264215] PD message len: 0
[    3.266563] IRQ: 0x41, a: 0x00, b: 0x00, status0: 0x93
[    3.266570] IRQ: BC_LVL, handler pending
[    3.300251] BC_LVL handler, status0=0x93
[    3.765635] IRQ: 0x41, a: 0x00, b: 0x01, status0: 0x93
[    3.765645] IRQ: BC_LVL, handler pending
[    3.765651] IRQ: PD sent good CRC
[    3.768956] PD message header: 176f
[    3.768963] PD message len: 4
[    3.770945] IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x93
[    3.770953] IRQ: BC_LVL, handler pending
[    3.772875] sending PD message header: 124f
[    3.772884] sending PD message len: 4
[    3.774781] IRQ: 0x41, a: 0x00, b: 0x00, status0: 0x93
[    3.774795] IRQ: BC_LVL, handler pending
[    3.776707] IRQ: 0x51, a: 0x04, b: 0x00, status0: 0x93
[    3.776722] IRQ: BC_LVL, handler pending
[    3.776733] IRQ: PD tx success
[    3.778512] PD message header: 361
[    3.778519] PD message len: 0
[    3.812321] BC_LVL handler, status0=0x93

> Which kernel are you running by the way?

plain 5.5.0-rc6-next-20200120 + patch [2]

> 
>> In vendor kernel (4.4) this is done somehow but the sources are too different for me to find
>> out how.
>> 
>> Gruß,
>> -- 
>> Markus Reichl
>> 
>> [1]
>> http://download.t-firefly.com/product/RK3399/Docs/Hardware/%E5%8E%9F%E7%90%86%E5%9B%BE%E5%92%8C%E8%B4%B4%E7%89%87%E5%9B%BE/ROC-RK3399-PC/ROC-3399-PC-V10-A-20180804_%E5%8E%9F%E7%90%86%E5%9B%BE.pdf
>> 
>> [2]
>> https://lkml.org/lkml/2019/12/10/517
> 

Gruß,
-- 
Markus Reichl

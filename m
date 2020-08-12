Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794082054F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzKnl00X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLBo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHLBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:44:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36FCC06174A;
        Tue, 11 Aug 2020 18:44:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so386527pls.4;
        Tue, 11 Aug 2020 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBQF/fgmbMDma0M0xPqkX1ISUSD5v+Eckv68glV6L+g=;
        b=nzKnl00XT8Txb9yB5K5fIkkQqXj9JFjIgRlnATLkA6hFA1Ujm2ITqB1kJc6ar8spMR
         9O+XZujznmiqUL7st7lWlXywbeW2c37WrcEid2pTZhh7d3dQ9SHkNNH3RrJKtv9BLrAh
         aaI6Ztc47zLhDHed3cdJ2PLemjY4jmRvnlw8V7l1aJATHUZuaehSNlEbbhTHWg8HkS6e
         cEk+G7aeI7yKHLtqNjp2X7zbavwBuyFDGXqN5fZhw3Y29IxnRn5WSxqs2ZP5XAQ5H+2x
         0iF28ffkNF6KNh0ap6LERFLhbS9feA9mJ8UudV1rMpdTXrciEk86mYOy1pWckfmM+XvV
         dyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jBQF/fgmbMDma0M0xPqkX1ISUSD5v+Eckv68glV6L+g=;
        b=hziaQhJb7RdoSmWAbdatCsSBTBMiUShvKEgN2uLabUeNP89MDSBINxZkBDYXTB/lG4
         7nE4sttbb2CPSuO5Bl1xHukqrSKR4/yRip7GpAo2rPLKzzRxU6ZpCHNiLwWN66tUB6F1
         CzMnzeASjIOJuGEJxAKKbcc3ylKq99CngMatyGY+N2/1HiM1q7tw8vz/rHhM9tsiNVRT
         HJdccbHsNDRcfjPF4a8pq9uN/JTSC/iF+WXT8LX9NF6DCNo9mh+712Ac4ZEcplACPbOp
         dlTzqIMf8RKsVbUo0ibOiYIvahsiO2Y/yHWcQu6gj7SMsLOZwJbsI+ksE5+BKX6PnsxH
         tWCg==
X-Gm-Message-State: AOAM531DBNBDgZpJV14F15RIvKR0SpM7/xYbIBsvMTysvwYR5FFHX7iZ
        YCno0lhD83hPtA/TwWw7U1pZTvAG
X-Google-Smtp-Source: ABdhPJyZdI1KnD2tooza9KrvXHh/enZ9rDGD7+gDMqE14aQ7pLNQrH5j0iR7KuN+PVoT1u9B6M5eHA==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr3406656plb.106.1597196667962;
        Tue, 11 Aug 2020 18:44:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5sm362509pfk.15.2020.08.11.18.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 18:44:26 -0700 (PDT)
Subject: Re: [PATCH v1] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2
 failures
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200811011126.130297-1-badhri@google.com>
 <ef32ea96-16c8-772b-2c80-8df43ee8f668@roeck-us.net>
 <CAPTae5Lhty3rJymi-4gANjUoz79_LujdjddS9oT=vpOxTSecdQ@mail.gmail.com>
 <20200811184507.GB86545@roeck-us.net>
 <CAPTae5KFxTS+QPnN1Qt_miOFdVYuyuDD2m=jH_Fo87F_C4tTBw@mail.gmail.com>
 <8a2e77f4-1470-ebf0-402c-df90ab6332bb@roeck-us.net>
 <CAPTae5J9qfJzkqykYJyM=FNHb2qdW6CJ2sNJmXCe9hbfE+o0Kw@mail.gmail.com>
 <ccfa822c-bbd7-7894-8d33-b8d25814b042@roeck-us.net>
 <CAPTae5LBW=4bYkP2kaRTmdd0EcVxHD8PNVxpX7S6D4GCmVS4bg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5461f039-ca37-daaa-78c1-d6fc69d17004@roeck-us.net>
Date:   Tue, 11 Aug 2020 18:44:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPTae5LBW=4bYkP2kaRTmdd0EcVxHD8PNVxpX7S6D4GCmVS4bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 6:08 PM, Badhri Jagan Sridharan wrote:
> Yes I did ! https://lkml.org/lkml/2020/8/11/788 !
> 
> For me gmail is grouping V1 and V2 patches in the same thread so
> thought you saw the v2 patch :P
> 

You copied me on v1, but not on v2. I am not on any of the mailing lists
you sent v2 to, so I did not see it.

Guenter

> Thanks,
> Badhri
> 
> On Tue, Aug 11, 2020 at 5:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 8/11/20 4:21 PM, Badhri Jagan Sridharan wrote:
>>> Thanks Guenter ! However I don't see a reviewed-by tag :)
>>>
>>
>> Confused. Did you send a v2 with the changes we discussed ?
>> I didn't see that.
>>
>> Thanks,
>> Guenter
>>
>>> On Tue, Aug 11, 2020 at 1:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 8/11/20 12:39 PM, Badhri Jagan Sridharan wrote:
>>>>> On Tue, Aug 11, 2020 at 11:45 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>
>>>>>> On Tue, Aug 11, 2020 at 11:24:07AM -0700, Badhri Jagan Sridharan wrote:
>>>>>>> On Mon, Aug 10, 2020 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>>>
>>>>>>>> On 8/10/20 6:11 PM, Badhri Jagan Sridharan wrote:
>>>>>>>>> >From the spec:
>>>>>>>>> "7.1.5 Response to Hard Resets
>>>>>>>>> Hard Reset Signaling indicates a communication failure has occurred and
>>>>>>>>> the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
>>>>>>>>> and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
>>>>>>>>> May reset during a Hard Reset since the VBUS voltage will be less than
>>>>>>>>> vSafe5V for an extended period of time. After establishing the vSafe0V
>>>>>>>>> voltage condition on VBUS, the Source Shall wait tSrcRecover before
>>>>>>>>> re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
>>>>>>>>> to the VCONN timing as specified in [USB Type-C 1.3]."
>>>>>>>>>
>>>>>>>>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++---
>>>>>>>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>>>>>>>> index 3ef37202ee37..e41c4e5d3c71 100644
>>>>>>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>>>>>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>>>>>>>> @@ -3372,13 +3372,19 @@ static void run_state_machine(struct tcpm_port *port)
>>>>>>>>>                       tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
>>>>>>>>>               break;
>>>>>>>>>       case SRC_HARD_RESET_VBUS_OFF:
>>>>>>>>> -             tcpm_set_vconn(port, true);
>>>>>>>>> +             /*
>>>>>>>>> +              * 7.1.5 Response to Hard Resets
>>>>>>>>> +              * Hard Reset Signaling indicates a communication failure has occurred and the
>>>>>>>>> +              * Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin and Shall
>>>>>>>>> +              * drive VBUS to vSafe0V as shown in Figure 7-9.
>>>>>>>>> +              */
>>>>>>>>> +             tcpm_set_vconn(port, false);
>>>>>>>>>               tcpm_set_vbus(port, false);
>>>>>>>>>               tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
>>>>>>>>>                              tcpm_data_role_for_source(port));
>>>>>>>>> -             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
>>>>>>>>
>>>>>>>> I am a bit concerned about this. If I understand correctly, it means that
>>>>>>>> we won't turn VBUS back on unless a SRC_HARD_RESET_VBUS_OFF PD event is received.
>>>>>>>> Is that correct ? What happens if that event is never received ?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Guenter
>>>>>>>
>>>>>>> The term PD event is a little ambiguous to me. Trying to summarize the workflow.
>>>>>>> Lower level tcpc driver would have to call tcpm_vbus_change which
>>>>>>> would in-turn trigger TCPM_VBUS_EVENT
>>>>>>> and queries port->tcpc->get_vbus to get the vbus status. It is not
>>>>>>> really a PD protocol driven event hence the
>>>>>>> confusion.
>>>>>>>
>>>>>>> "What happens if that event is never received ?"
>>>>>>> Yeah TCPM would be in SRC_HARD_RESET_VBUS_OFF till the tcpc calls the
>>>>>>> tcpm_vbus_change.
>>>>>>> Do you suspect that existing tcpc would not have the capability to
>>>>>>> monitor vbus status while sourcing and call tcpm_vbus_change?
>>>>>>>
>>>>>> That, or the driver might be buggy, or the hardware does't signal a status
>>>>>> update, or the update gets lost. I think we should have some backup,
>>>>>> to trigger if the event is not received in a reasonable amout of time.
>>>>>> I don't know if the specification has some kind of maximum limit. If
>>>>>> not, we should still have something
>>>>>>
>>>>>> Thanks,
>>>>>> Guenter
>>>>>
>>>>> Got it ! The specification actually has a bound for vbus off.
>>>>> tSafe0V  - Time to reach vSafe0V max - 650ms. (PD_T_SAFE_0V).
>>>>> So I will bound it to that.
>>>>>
>>>>
>>>> Excellent. Thanks a lot for looking into this!
>>>>
>>>> Guenter
>>>>
>>>>> >From Table 7-12 Sequence Description for a Source Initiated Hard Reset:
>>>>> 4.Policy Engine waits tPSHardReset after sending Hard Reset Signaling
>>>>> and then tells the Device Policy Manager to instruct the power supply
>>>>> to perform a Hard Reset. The transition to vSafe0V Shall occur within
>>>>> tSafe0V (t2).
>>>>> 5 After tSrcRecover the Source applies power to VBUS in an attempt to
>>>>> re-establish communication with the Sink and resume USB Default
>>>>> Operation. The transition to vSafe5V Shall occur within tSrcTurnOn
>>>>> (t4).
>>>>>
>>>>> Thanks,
>>>>> Badhri
>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Badhri
>>>>>>>
>>>>>>>
>>>>>>>>>               break;
>>>>>>>>>       case SRC_HARD_RESET_VBUS_ON:
>>>>>>>>> +             tcpm_set_vconn(port, true);
>>>>>>>>>               tcpm_set_vbus(port, true);
>>>>>>>>>               port->tcpc->set_pd_rx(port->tcpc, true);
>>>>>>>>>               tcpm_set_attached_state(port, true);
>>>>>>>>> @@ -3944,7 +3950,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>>>>>>>>>               tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
>>>>>>>>>               break;
>>>>>>>>>       case SRC_HARD_RESET_VBUS_OFF:
>>>>>>>>> -             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, 0);
>>>>>>>>> +             /*
>>>>>>>>> +              * After establishing the vSafe0V voltage condition on VBUS, the Source Shall wait
>>>>>>>>> +              * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
>>>>>>>>> +              */
>>>>>>>>> +             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
>>>>>>>>>               break;
>>>>>>>>>       case HARD_RESET_SEND:
>>>>>>>>>               break;
>>>>>>>>>
>>>>>>>>
>>>>
>>


Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF0C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3AD20747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv2u0tJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEFTh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgEFThz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:37:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A32C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 12:37:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so3827520wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PMfnV+lBYuokg7imQgD9+Xg154NUqkCBemshwAfLsOk=;
        b=Yv2u0tJZG6FMaNCaiLn491TCNZ9/0esnWwlEkLeWCMeMFT+ndsKiJHFJf2ozamFTkJ
         ILtmwJa/PkuWHmkxdGeLsTttPnqitJ5cZXfqILJSQ1x+rnbb43z5mTnktK0Za+R0E6T1
         CB9utCCS2dQK/DKXSpNrdsTco0VrLqnXjrSt4JOk24SKT2zVWOOFllgKTdB3ZujDmZKa
         Pse5y5j8o2a+jQIMSr+6wNcbjPQ1NXXWx4aY/JluY6MoYHIW92K+L28TC2/wVQdkziu5
         limXkOROTNPJf7eYMr3uG/qZFqEnebTi1wu5VyBatN7MddvhprVhFBa4fH3XVTxzHSXM
         oy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PMfnV+lBYuokg7imQgD9+Xg154NUqkCBemshwAfLsOk=;
        b=s9JILz++JL7Vtz1fmuGaDNMqNC7SyRqKZqUYRnZDw95fsyk+vvieAqSMqzuv0f/DGn
         J7c+I1ae2FGuWLjK7YMipHfUJxokpspjCr/m2puleTyI32m+AYE5baP4BC5SwvxMHGAo
         aSoQdK9lTu4pg8KgdQyspP0jOuslkqxUgdtxyZwZlS6JQPbjjSqd/8ZTcFpIfSrDZ+gN
         xmlxytu/9PCaI+MdH0veDM2di3Ofk0ydd6t0F5Y+gZthxmI+uHSTkUiakGnZmE4sMN0O
         l7P3JMFjlIwMyseS1ncsonzJeAaeJuDZD+BjpgCxN+pPskVXHJBO8BV1ampPOotk0BGj
         zxcQ==
X-Gm-Message-State: AGi0PuZY/2K+QrHRq1idjyh1DeH8YmHOT6e4/VJbZEMp3coYjoXvIlsg
        nxrEe6VE13IAJhmjAnZC6TibMopZ
X-Google-Smtp-Source: APiQypJVIp4Au8e2R9c91P/ojnlDJTGQeXacjZfEtv1U4dxgSrejP6h+fcGk73BKCLoch9osCaa1Cw==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr4184885wma.144.1588793871225;
        Wed, 06 May 2020 12:37:51 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A4BD.dip0.t-ipconnect.de. [217.229.164.189])
        by smtp.gmail.com with ESMTPSA id y63sm4667176wmg.21.2020.05.06.12.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 12:37:50 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [Regression] [Bisected] Commit
 6d232b29cfce65961db4a668c2c6c6987cd24d45 breaks some of the Fn-keys on my old
 Sony Vaio VPCM13M1E.
To:     Fabio Comolli <fabio.comolli@mail.polimi.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "robert.moore@intel.com" <robert.moore@intel.com>,
        "rik.kaneda@intel.com" <rik.kaneda@intel.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
References: <HE1PR0602MB335553397CB175052E00EF70DAA40@HE1PR0602MB3355.eurprd06.prod.outlook.com>
Message-ID: <a0620def-e9a7-82d8-d01e-3ac8c62891b4@gmail.com>
Date:   Wed, 6 May 2020 21:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0602MB335553397CB175052E00EF70DAA40@HE1PR0602MB3355.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 5:16 PM, Fabio Comolli wrote:
> Hi,
> 
> I updated my old Sony Vaio a few days ago and discovered that a few Fn-keys on my old Sony Vaio had stopped working.
> The bisection points at the commit in the subject and reverting it makes everything work again even with current
> Linus' git.

Hi,

the underlying issue is currently being discussed in a couple of places.
See

     https://bugzilla.kernel.org/show_bug.cgi?id=207491
     https://bugzilla.redhat.com/show_bug.cgi?id=1830150

Those links contain a patch and I believe this patch (or some version of
it) has already been proposed here in the mailing list.

Regards,
Maximilian

> Full bug report below. Please CC: me as I'm not subscribed to lkml.
> 
> Regards,
> Fabio
> 
> 
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> 
> BIOS table is:
> 
> [    0.000000] DMI: Sony Corporation VPCM13M1E/VAIO, BIOS R0120Z4 05/12/2010
> [    0.014701] ACPI: RSDP 0x00000000000F0410 000024 (v03 Sony  )
> [    0.014709] ACPI: XSDT 0x000000007F4DB078 00004C (v01 Sony   VAIO     20100512 AMI  00010013)
> [    0.014724] ACPI: FACP 0x000000007F4E1388 0000F4 (v04 Sony   VAIO     20100512 AMI  00010013)
> [    0.014740] ACPI: DSDT 0x000000007F4DB150 006231 (v02 Sony   VAIO     20100512 INTL 20051117)
> [    0.014751] ACPI: FACS 0x000000007F509F40 000040
> [    0.014758] ACPI: FACS 0x000000007F509F80 000040
> [    0.014766] ACPI: APIC 0x000000007F4E1480 000072 (v01 Sony   VAIO     20100512 AMI  00010013)
> [    0.014777] ACPI: MCFG 0x000000007F4E14F8 00003C (v01 Sony   VAIO     20100512 MSFT 00000097)
> [    0.014787] ACPI: SLIC 0x000000007F4E1538 000176 (v01 Sony   VAIO     20100512 Sony 01000000)
> [    0.014797] ACPI: HPET 0x000000007F4E16B0 000038 (v01 Sony   VAIO     20100512 AMI. 00000003)
> 
> There are 7 Fn-keys available on this model:
> 
> Mute
> Volume Down
> Volume Up
> Brightness Down
> Brightness Up
> External Video Output Switch
> Hibernate
> 
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> 
> Working versions write this in the messages log at boot time:
> 
> [   20.175244] input: Sony Vaio Keys as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/SNY5001:00/input/input5
> [   20.186497] input: Sony Vaio Jogdial as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/SNY5001:00/input/input6
> [   20.217724] sony_laptop: SNC setup done.
> 
> The acpi_listen output is:
> 
> button/mute MUTE 00000080 00000000 K
> button/volumedown VOLDN 00000080 00000000 K
> button/volumeup VOLUP 00000080 00000000 K
> video/brightnessdown BRTDN 00000087 00000000 K
> sony/hotkey SNY5001:00 00000001 00000010
> sony/hotkey SNY5001:00 00000001 0000003b
> video/brightnessup BRTUP 00000086 00000000 K
> sony/hotkey SNY5001:00 00000001 00000011
> sony/hotkey SNY5001:00 00000001 0000003b
> video/switchmode VMOD 00000080 00000000 K
> sony/hotkey SNY5001:00 00000001 00000012
> sony/hotkey SNY5001:00 00000001 0000003b
> 
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> 
> Broken versions write this in the messages log at boot time:
> 
> [   19.143613] input: Sony Vaio Keys as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/SNY5001:00/input/input6
> [   19.158941] input: Sony Vaio Jogdial as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/SNY5001:00/input/input7
> [   19.180118] sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
> [   19.184342] sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
> [   19.186183] sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
> [   19.188688] sony_laptop: SNC setup done.
> 
> The acpi_listen output is:
> 
> button/mute MUTE 00000080 00000000 K
> button/volumedown VOLDN 00000080 00000000 K
> button/volumeup VOLUP 00000080 00000000 K
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> sony/hotkey SNY5001:00 00000001 00000092
> 
> i.e. the brightness keys, the external output toggle and the hibernate button are not recognised anymore. Every keypress generates two identical "sony/hotkey SNY5001:00 00000001 00000092" in the acpi_listen output and the following lines in the messages log:
> 
> May  4 20:09:34 vaio kernel: sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
> May  4 20:09:34 vaio fcomolli[17675]: ACPI group/action undefined: sony/hotkey / SNY5001:00.
> 
> The volume and mute button always work.
> 
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> 
> Bisection output:
> 
> [fcomolli@vaio linux]$ git bisect good
> 6d232b29cfce65961db4a668c2c6c6987cd24d45 is the first bad commit
> commit 6d232b29cfce65961db4a668c2c6c6987cd24d45
> Author: Maximilian Luz <luzmaximilian@gmail.com>
> Date:   Tue Dec 17 11:35:22 2019 -0800
> 
>      ACPICA: Dispatcher: always generate buffer objects for ASL create_field() operator
>      
>      ACPICA commit 79a466b64e6af36cc83102f05915e56cb7dd89ab
>      
>      According to table 19-419 of the ACPI 6.3 specification, buffer_fields
>      created using the ASL create_field() Operator have been treated as
>      integers if the buffer_field is small enough to fit inside of an ASL
>      integer (32-bits or 64-bits depending on the definition block
>      revision). If they are larger, buffer fields are treated as ASL
>      Buffer objects. However, this is not true for other AML interpreter
>      implementations.
>      
>      It has been discovered that other AML interpreters always treat
>      buffer fields created by create_field() as a buffer regardless of the
>      length of the buffer field.
>      
>      More specifically, the Microsoft AML interpreter always treats buffer
>      fields created by the create_field() operator as buffer. ACPICA
>      currently does this only when the field size is larger than the
>      maximum integer width. This causes problems with AML code shipped in
>      Microsoft Surface devices.
>      
>      More details:
>      
>      The control methods in these devices determine the success of an ASL
>      control method execution by examining the type resulting from storing
>      a buffer field created by a create_field() operator. On success, a
>      Buffer object is expected, on failure an Integer containing an error
>      code. This buffer object is created with a dynamic size via the
>      create_field() operator. Due to the difference in behavior, Buffer
>      values of small size are however converted to Integers and thus
>      interpreted by the control method as having failed, whereas in
>      reality it succeeded. Below is an example of a control method called
>      TEST that illustrates this behavior.
>      
>      Method (CBUF) // Create a Buffer field
>      {
>          /*
>           * Depending on the value of RAND, ACPICA interpreter will treat
>           * BF00 as an integer or buffer.
>           */
>          create_field (BUFF, 0, RAND, BF00)
>          return (BF00)
>      }
>      
>      Method (TEST)
>      {
>          /*
>           * Storing the value returned by CBUF to local0 will result in
>           * implicit type conversion outlined in the ACPI specification.
>           *
>           * ACPICA will treat local0 like an ASL integer if RAND is less
>           * than or equal to 64 or 32 (depending on the definition_block
>           * revision). If RAND is greater, it will be treated like an ASL
>           * buffer. Other implementations treat local0 like an ASL buffer
>           * regardless of the value of RAND.
>           */
>          local0 = CBUF()
>      
>          /*
>           * object_type of 0x03 represents an ASL Buffer
>           */
>          if (object_type (Local0) != 0x03)
>          {
>              // Error on ACPICA if RAND is small enough
>          }
>          else
>          {
>              /*
>               * Success on APICA if RAND is large enough
>               * Other implementations always take this path because local0
>               * is always treated as a buffer.
>               */
>          }
>      }
>      
>      This change prohibits the previously mentioned integer conversion to
>      match other AML interpreter implementations (Microsoft) that do not
>      conform to the ACPI specification.
>      
>      Link: https://github.com/acpica/acpica/commit/79a466b6
>      Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>      Signed-off-by: Bob Moore <robert.moore@intel.com>
>      Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
>   drivers/acpi/acpica/acobject.h |  3 ++-
>   drivers/acpi/acpica/dsopcode.c |  2 ++
>   drivers/acpi/acpica/exfield.c  | 10 ++++++++--
>   3 files changed, 12 insertions(+), 3 deletions(-)
> 
> -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
> 
> [fcomolli@vaio linux]$ git bisect log
> git bisect start
> # bad: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
> git bisect bad 7111951b8d4973bda27ff663f2cf18b663d15b48
> # good: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
> git bisect good 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
> # good: [ee7dd7733b201c6201174f384a92dbadc9f3129c] sis900: remove TxIDLE
> git bisect good ee7dd7733b201c6201174f384a92dbadc9f3129c
> # good: [44bf67f32a6803339ac1ba721b158c3e2272cabe] Merge drm/drm-next into drm-misc-next
> git bisect good 44bf67f32a6803339ac1ba721b158c3e2272cabe
> # good: [7214618c60e947b8cea12b47d8279bd4220f21bc] Merge tag 'riscv/for-v5.5-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> git bisect good 7214618c60e947b8cea12b47d8279bd4220f21bc
> # bad: [4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb] Merge tag 'for-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
> git bisect bad 4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb
> # bad: [a78208e2436963d0b2c7d186277d6e1a9755029a] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad a78208e2436963d0b2c7d186277d6e1a9755029a
> # good: [9e1af7567b266dc6c3c8fd434ea807b3206bfdc1] Merge tag 'mmc-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> git bisect good 9e1af7567b266dc6c3c8fd434ea807b3206bfdc1
> # bad: [d99391ec2b42d827d92003dcdcb96fadac9d862b] Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad d99391ec2b42d827d92003dcdcb96fadac9d862b
> # good: [6d277aca488fdf0a1e67cd14b5a58869f66197c9] Merge tag 'pm-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 6d277aca488fdf0a1e67cd14b5a58869f66197c9
> # bad: [534b0a8b677443c0aa8c4c71ff7887f08a2b9b41] Merge tag 'core-debugobjects-2020-01-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 534b0a8b677443c0aa8c4c71ff7887f08a2b9b41
> # bad: [22a8f39c520fc577c02b4e5c99f8bb3b6017680b] Merge tag 'for-5.6/drivers-2020-01-27' of git://git.kernel.dk/linux-block
> git bisect bad 22a8f39c520fc577c02b4e5c99f8bb3b6017680b
> # bad: [34dabd81160f7bfb18b67c1161b3c4d7ca6cab83] Merge tag 'pnp-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad 34dabd81160f7bfb18b67c1161b3c4d7ca6cab83
> # bad: [3dd855147feff375dfa6737331628ea919e9da59] Merge branches 'acpi-battery', 'acpi-video', 'acpi-fan' and 'acpi-drivers'
> git bisect bad 3dd855147feff375dfa6737331628ea919e9da59
> # bad: [ff7a672f83b355365478a1fdfb60933ef34d8d02] Merge branch 'acpica'
> git bisect bad ff7a672f83b355365478a1fdfb60933ef34d8d02
> # bad: [ae6252d8dfeb21f5067a09a8f4a6dd30851d70c1] ACPICA: Update version to 20191213
> git bisect bad ae6252d8dfeb21f5067a09a8f4a6dd30851d70c1
> # good: [5ddbd77181dfca61b16d2e2222382ea65637f1b9] ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
> git bisect good 5ddbd77181dfca61b16d2e2222382ea65637f1b9
> # bad: [6d232b29cfce65961db4a668c2c6c6987cd24d45] ACPICA: Dispatcher: always generate buffer objects for ASL create_field() operator
> git bisect bad 6d232b29cfce65961db4a668c2c6c6987cd24d45
> # good: [69e86e59ad2a2518704a31c35530e6e99963c358] ACPICA: acpisrc: add unix line ending support for non-windows build
> git bisect good 69e86e59ad2a2518704a31c35530e6e99963c358
> # first bad commit: [6d232b29cfce65961db4a668c2c6c6987cd24d45] ACPICA: Dispatcher: always generate buffer objects for ASL create_field() operator
> 

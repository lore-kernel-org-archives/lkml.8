Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81614C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6702071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n274YDCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHYS2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYS2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:28:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:28:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i20so11949863qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IlWDX6pvS6a0ARlt5fWOo7pf4AarWbO+xLIW45mVJYs=;
        b=n274YDCT/w8v69L3AOUMJPpxPbHXG8vZHpxTG5Rv7YRwu553yEWizUpiIqzcMjMxEI
         QqOM5ZwacHdcy6NXz3mtMVnjPFkFH+CSLwXJLuCfaPOr1/FCRhxhv/Io4C5jnynbcI7C
         JAc8qiv+GVEx7Duz0kj/Yf/zxo63Y1l1FzcK+xNe7+Bs4tDxk/ufXzMhVVGU99w8LPI5
         SQRupvw8cCySOad1Tm97jMbCP2hyR0voGHI6cPIRnfX4EKsYMpJhgkSXwse1Ox3ZiRlH
         At124tYZ449mfUZV3syYME3JN4GZ1FqZ4uUW6c/WZoA10V/fJqzOpME7NztFFVG4D2VM
         L07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IlWDX6pvS6a0ARlt5fWOo7pf4AarWbO+xLIW45mVJYs=;
        b=iE9tBLILF3CcuB2i6Wd6tl/syKCq1MROHXMYSa3FH8P+0jNnFeiZn1ARSY+epaUKSy
         mR5mTDgXivok9yPTEnfddpBaHanp6gDsM+AqWC94AVDq3VdKKYE1u7k0++praouaqbE7
         o82d61diX53JSqXqoT03Iac4G/ouOZq8a8fpu4UrnNzkHEAfZ5CwMUqzgFEr9fnoc4/R
         J+MF9DlVO9n5sRl/6KzmouguDO27tDc20F/myck0oxinX19qlY8WkDOUaXNUN21aa7vE
         puTNIKc3HMN+QdPpIgR/nHh82XU/kSYDfPJo42hVpROUXWY+G4F51l+LWLU+VfDdCd4+
         K1lw==
X-Gm-Message-State: AOAM531gMffN0XKMC0e42KVagGQUBlR+0mklWUvJlH7dbmPLjW7cIDw3
        7piwz1Nu62pX3fVftzVNgU1N1lME+mMq1x0bqp5W+gBByYh/Rg==
X-Google-Smtp-Source: ABdhPJylI2y8yymc3SRTmlzTpOFV2Y3UCEjPTlT+oMzljHfJgZfv3b9oxteHAMQXNNzY0KBUxT01kuUD6F5bQ9oD5+E=
X-Received: by 2002:a37:6351:: with SMTP id x78mr10553854qkb.394.1598380103985;
 Tue, 25 Aug 2020 11:28:23 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 25 Aug 2020 13:28:12 -0500
Message-ID: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
Subject: localmodconfig - "intel_rapl_perf config not found!!"
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Haswell
Linux 5.8.3

First time I've used localmodconfig ever since reading what it does
and liking the "supposed" kernel customization specific to the system.
I only use quotes on "supposed" because I DO still see entries I have
no interest in (not applicable to my system/needs).
I don't know if another email would be warranted for localmodconfig
only or if my expectation of it is unrealistic.

The "intel_rapl_perf config not found!!" comes up with every .config I try.
The simplest test I can come up with would be:
*****
make defconfig //x86_64_defconfig
lsmod > lsmod.cfg
make localmodconfig LSMOD=lsmod.cfg
*****

lsmod.cfg
*****
Module                  Size  Used by
uinput                 20480  1
rfcomm                 94208  16
ccm                    20480  9
cmac                   16384  5
algif_hash             16384  2
bnep                   28672  2
btrfs                1556480  1
blake2b_generic        20480  0
xor                    24576  1 btrfs
raid6_pq              122880  1 btrfs
libcrc32c              16384  1 btrfs
crc32c_generic         16384  0
nls_iso8859_1          16384  1
nls_cp437              20480  1
vfat                   24576  1
fat                    90112  1 vfat
snd_usb_audio         311296  0
snd_usbmidi_lib        45056  1 snd_usb_audio
snd_rawmidi            45056  1 snd_usbmidi_lib
snd_seq_device         16384  1 snd_rawmidi
tda18271               53248  1
au8522_dig             16384  1
au8522_common          16384  1 au8522_dig
au0828                 69632  1
tveeprom               28672  1 au0828
dvb_core              176128  1 au0828
videobuf2_vmalloc      20480  2 dvb_core,au0828
videobuf2_memops       20480  1 videobuf2_vmalloc
videobuf2_v4l2         28672  1 au0828
intel_rapl_msr         20480  0
btusb                  57344  0
videodev              274432  2 videobuf2_v4l2,au0828
btrtl                  24576  1 btusb
btbcm                  20480  1 btusb
videobuf2_common       57344  3 videobuf2_v4l2,dvb_core,au0828
intel_rapl_common      32768  1 intel_rapl_msr
rc_core                61440  1 au0828
btintel                32768  1 btusb
bluetooth             688128  49 btrtl,btintel,btbcm,bnep,btusb,rfcomm
x86_pkg_temp_thermal    20480  0
intel_powerclamp       20480  0
mousedev               24576  0
ecdh_generic           16384  2 bluetooth
ecc                    36864  1 ecdh_generic
crc16                  16384  1 bluetooth
rtl8821ae             290816  0
coretemp               20480  0
snd_hda_codec_hdmi     73728  1
btcoexist             225280  1 rtl8821ae
kvm_intel             335872  0
rtl_pci                36864  1 rtl8821ae
rtlwifi               139264  3 rtl_pci,rtl8821ae,btcoexist
kvm                   876544  1 kvm_intel
iTCO_wdt               16384  0
mei_hdcp               24576  0
iTCO_vendor_support    16384  1 iTCO_wdt
mac80211              954368  3 rtl_pci,rtl8821ae,rtlwifi
i915                 2703360  60
snd_hda_codec_realtek   143360  1
irqbypass              16384  1 kvm
snd_hda_codec_generic    98304  1 snd_hda_codec_realtek
ledtrig_audio          16384  2 snd_hda_codec_generic,snd_hda_codec_realtek
intel_cstate           16384  0
snd_hda_intel          53248  4
snd_soc_rt5640        147456  0
intel_uncore          163840  0
cfg80211              925696  2 rtlwifi,mac80211
snd_intel_dspcfg       24576  1 snd_hda_intel
snd_soc_rl6231         20480  1 snd_soc_rt5640
intel_rapl_perf        16384  2
snd_hda_codec         176128  4
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
snd_soc_core          311296  1 snd_soc_rt5640
rfkill                 32768  11 bluetooth,cfg80211
libarc4                16384  1 mac80211
snd_compress           32768  1 snd_soc_core
alx                    57344  0
input_leds             16384  0
snd_hda_core          114688  5
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
i2c_algo_bit           16384  1 i915
ac97_bus               16384  1 snd_soc_core
snd_pcm_dmaengine      16384  1 snd_soc_core
snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
mdio                   16384  1 alx
drm_kms_helper        266240  1 i915
snd_pcm               159744  9
snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_soc_rt5640,snd_compress,snd_soc_core,snd_hda_core,snd_pcm_dmaengine
cec                    69632  2 drm_kms_helper,i915
snd_timer              49152  1 snd_pcm
mei_me                 49152  1
intel_gtt              24576  1 i915
syscopyarea            16384  1 drm_kms_helper
sysfillrect            16384  1 drm_kms_helper
sysimgblt              16384  1 drm_kms_helper
snd                   118784  22
snd_hda_codec_generic,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_compress,snd_soc_core,snd_pcm,snd_rawmidi
fb_sys_fops            16384  1 drm_kms_helper
soundcore              16384  1 snd
mei                   131072  3 mei_hdcp,mei_me
i2c_i801               36864  0
lpc_ich                28672  0
evdev                  28672  12
mac_hid                16384  0
pcspkr                 16384  0
drm                   606208  16 drm_kms_helper,i915
agpgart                53248  2 intel_gtt,drm
ip_tables              36864  0
x_tables               53248  1 ip_tables
f2fs                  630784  1
dm_crypt               49152  2
serpent_avx2           49152  4
serpent_avx_x86_64     49152  1 serpent_avx2
serpent_sse2_x86_64    53248  0
serpent_generic        32768  5
serpent_avx2,serpent_sse2_x86_64,serpent_avx_x86_64
algif_skcipher         16384  2
af_alg                 36864  10 algif_hash,algif_skcipher
uas                    32768  0
usb_storage            81920  3 uas
sr_mod                 28672  0
sd_mod                 61440  5
cdrom                  77824  1 sr_mod
hid_logitech_hidpp     45056  0
hid_logitech_dj        28672  0
hid_generic            16384  0
usbhid                 65536  1 hid_logitech_dj
hid                   143360  4
usbhid,hid_generic,hid_logitech_dj,hid_logitech_hidpp
crct10dif_pclmul       16384  1
crc32_pclmul           16384  1
serio_raw              20480  0
crc32c_intel           24576  2
atkbd                  36864  0
libps2                 20480  1 atkbd
ghash_clmulni_intel    16384  0
ahci                   40960  1
libahci                45056  1 ahci
libata                303104  2 libahci,ahci
aesni_intel           372736  13
scsi_mod              274432  5 sd_mod,usb_storage,uas,libata,sr_mod
crypto_simd            16384  4
serpent_avx2,serpent_sse2_x86_64,aesni_intel,serpent_avx_x86_64
cryptd                 28672  6 crypto_simd,ghash_clmulni_intel
glue_helper            16384  4
serpent_avx2,serpent_sse2_x86_64,aesni_intel,serpent_avx_x86_64
xhci_pci               20480  0
xhci_hcd              294912  1 xhci_pci
ehci_pci               20480  0
ehci_hcd               98304  1 ehci_pci
i8042                  32768  0
serio                  28672  4 serio_raw,atkbd,i8042
dm_mod                167936  10 dm_crypt
pkcs8_key_parser       16384  0
nct6775                77824  0
hwmon_vid              16384  1 nct6775
crypto_user            16384  0
*****

That alone is problematic in that localmodconfig is only going by
what's in the .config and not filling in the blanks, so I have to
"make menuconfig" and go through each "module <*> did not have configs
<CONFIG_*>" and manually set them.

But even after I take care of all the missing entries, the
"intel_rapl_perf" still comes up when running localmodconfig again.

I'm going to assume it has something to do with the naming and it's
supposed to be associated with "Intel/AMD rapl performance events
(CONFIG_PERF_EVENTS_INTEL_RAPL)" which I already have set to 'Y'.
Right below that, I also get 'Use of uninitialized value
$ENV{"LMC_KEEP"} in split at ./scripts/kconfig/streamline_config.pl
line 596.', but again that is the sort of thing that may warrant a new
email specific to localmodconfig author(s). But again maybe not
because I take it more as a warning given I don't make use of
LMC_KEEP.
